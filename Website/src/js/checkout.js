"use strict";

import { BeaconDialog } from "./classes/BeaconDialog.js";
import { BeaconWebRequest } from "./classes/BeaconWebRequest.js";
import { getCurrencyFormatter, formatPrices, formatDate, epochToDate, randomUUID } from "./common.js";

const StatusOwns = 'owns'; // User has a license for the item
const StatusBuying = 'buying'; // The user is buying it in this cart item
const StatusInCart = 'in-cart'; // The user has it in their cart elsewhere
const StatusNone = 'none';

const MaxRenewalCount = 5;

const validateEmail = (email) => {
	const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(String(email).trim().toLowerCase());
};

document.addEventListener('beaconRunCheckout', ({checkoutProperties}) => {
	const Products = checkoutProperties.products;
	const ProductIds = checkoutProperties.productIds;
	const formatCurrency = getCurrencyFormatter(checkoutProperties.currencyCode);

	class BeaconCartItem {
		#id = null;
		#products = {};
		#isGift = false;

		constructor(config) {
			if (config) {
				this.#id = config.id;
				this.#products = config.products;
				this.#isGift = config.isGift;
			} else {
				this.#id = randomUUID();
			}
		}

		get id() {
			return this.#id;
		}

		get isGift() {
			return this.#isGift;
		}

		set isGift(newValue) {
			this.#isGift = newValue;
		}

		get productIds() {
			return Object.keys(this.#products);
		}

		get count() {
			return Object.keys(this.#products).length;
		}

		reset() {
			this.#products = {};
		}

		add(productId, quantity) {
			this.setQuantity(productId, this.getQuantity(productId) + quantity);
		}

		remove(productId, quantity) {
			this.setQuantity(productId, this.getQuantity(productId) - quantity);
		}

		getQuantity(productId) {
			return this.#products[productId] ?? 0;
		}

		setQuantity(productId, quantity) {
			if (quantity <= 0) {
				if (Object.prototype.hasOwnProperty.call(this.#products, productId)) {
					delete this.#products[productId];
				}
			} else {
				this.#products[productId] = quantity;
			}
		}

		toJSON() {
			return {
				id: this.#id,
				products: this.#products,
				isGift: this.#isGift,
			};
		}

		get fingerprint() {
			const sorted = Object.keys(this.#products).sort().reduce((obj, key) => {
				obj[key] = this.#products[key];
				return obj;
			}, {});

			return btoa(JSON.stringify({
				id: this.#id,
				products: sorted,
				isGift: this.#isGift,
			}));
		}

		get hasArk() {
			return this.getQuantity(Products?.Ark?.Base?.ProductId) > 0;
		}

		get hasArkSA() {
			return this.getQuantity(Products?.ArkSA?.Base?.ProductId) > 0 || this.getQuantity(Products?.ArkSA?.Upgrade?.ProductId) > 0 || this.getQuantity(Products?.ArkSA?.Renewal?.ProductId) > 0;
		}

		get arkSAYears() {
			return Math.min(this.getQuantity(Products?.ArkSA?.Base?.ProductId) + this.getQuantity(Products?.ArkSA?.Upgrade?.ProductId) + this.getQuantity(Products?.ArkSA?.Renewal?.ProductId), 10);
		}

		build(targetCart, isGift, withArk, arkSAYears) {
			this.reset();
			this.isGift = isGift;

			if (withArk && (isGift || targetCart.arkLicense === null)) {
				this.setQuantity(Products.Ark.Base.ProductId, 1);
			}

			if (arkSAYears > 0) {
				arkSAYears = Math.min(arkSAYears, MaxRenewalCount);

				if (isGift) {
					if (withArk) {
						this.setQuantity(Products.ArkSA.Upgrade.ProductId, 1);
					} else {
						this.setQuantity(Products.ArkSA.Base.ProductId, 1);
					}
					if (arkSAYears > 1) {
						this.setQuantity(Products.ArkSA.Renewal.ProductId, arkSAYears - 1);
					}
				} else {
					if (targetCart.arkSALicense !== null) {
						this.setQuantity(Products.ArkSA.Renewal.ProductId, arkSAYears);
					} else {
						if (withArk || targetCart.arkLicense !== null) {
							this.setQuantity(Products.ArkSA.Upgrade.ProductId, 1);
						} else {
							this.setQuantity(Products.ArkSA.Base.ProductId, 1);
						}
						if (arkSAYears > 1) {
							this.setQuantity(Products.ArkSA.Renewal.ProductId, arkSAYears - 1);
						}
					}
				}
			}
		}

		rebuild(targetCart) {
			const oldFingerprint = this.fingerprint;
			this.build(targetCart, this.isGift, this.hasArk, this.arkSAYears);
			return this.fingerprint !== oldFingerprint;
		}

		consume(cart, otherLineItem) {
			if (!otherLineItem) {
				return;
			}

			if (this.isGift !== otherLineItem.isGift) {
				throw new Error('Cannot merge a gift item with a non-gift item.');
			}

			const includeArk = this.hasArk || otherLineItem.hasArk;
			const arkSAYears = this.arkSAYears + otherLineItem.arkSAYears;
			this.build(cart, this.isGift, includeArk, arkSAYears);
		}

		get total() {
			const ids = this.productIds;
			let total = 0;
			for (const productId of ids) {
				total += ProductIds[productId]['Price'] * this.getQuantity(productId);
			}
			return total;
		}
	}

	class BeaconCart {
		#items = [];
		#email = null;
		#emailVerified = false;
		#licenses = [];

		constructor(saved = null) {
			if (saved) {
				try {
					const parsed = JSON.parse(saved);
					this.#email = parsed.email;
					this.#items = parsed.items.reduce((items, savedItem) => {
						const cartItem = new BeaconCartItem(savedItem);
						if (cartItem.count > 0) {
							items.push(cartItem);
						}
						return items;
					}, []);
					this.#licenses = parsed.licenses;
				} catch (e) {
					console.log('Failed to load saved cart');
				}
			}
		}

		reset() {
			this.#items = [];
			this.#email = null;
			this.#emailVerified = false;
			this.#licenses = [];
			this.save();
		}

		toJSON() {
			return {
				email: this.#email,
				items: this.#items.reduce((items, cartItem) => {
					if (cartItem.count > 0) {
						items.push(cartItem);
					}
					return items;
				}, []),
				licenses: this.#licenses,
			};
		}

		save() {
			localStorage.setItem('beaconCart', JSON.stringify(this));
		}

		static load() {
			return new this(localStorage.getItem('beaconCart'));
		}

		add(item) {
			this.#items.push(item);
			this.save();
		}

		remove(item) {
			this.#items = this.#items.filter((cartItem) => cartItem.id !== item.id);
			this.save();
		}

		hasProduct(productId, isGift = false) {
			for (const lineItem of this.#items) {
				if (lineItem.getQuantity(productId) > 0 && lineItem.isGift === isGift) {
					return true;
				}
			}
			return false;
		}

		get email() {
			return this.#email;
		}

		setEmail(newEmail) {
			return new Promise((resolve, reject) => {
				// Returns true if the cart was changed
				const rebuildCart = () => {
					const cartItem = this.personalCartItem;
					if (!cartItem) {
						return false;
					}

					if (cartItem.hasArk && this.arkLicense) {
						cartItem.setQuantity(Products.Ark?.Base?.ProductId, 0);
						if (cartItem.count === 0) {
							this.remove(cartItem);
						}
						return true;
					}

					return cartItem.rebuild(this);
				};

				if (newEmail === null) {
					this.#email = null;
					this.#emailVerified = false;
					this.#licenses = [];
					const cartChanged = rebuildCart();
					this.save();
					resolve({newEmail: null, cartChanged});
					return;
				}

				if (!validateEmail(newEmail)) {
					reject('Address is not valid');
					return;
				}

				const params = new URLSearchParams();
				params.append('email', newEmail);

				BeaconWebRequest.get(`/omni/lookup?${params.toString()}`).then((response) => {
					const info = JSON.parse(response.body);
					this.#email = info.email;
					this.#emailVerified = info.verified;
					this.#licenses = info.purchases;
					const cartChanged = rebuildCart();
					this.save();
					resolve({newEmail, cartChanged});
				}).catch((error) => {
					this.#email = null;
					this.#emailVerified = false;
					this.#licenses = [];
					rebuildCart();
					this.save();
					reject(error.statusText);
				});
			});
		}

		get emailVerified() {
			return this.#emailVerified;
		}

		get checkingEmail() {
			return false;
		}

		get items() {
			return [...this.#items];
		}

		get count() {
			return this.#items.reduce((bundles, cartItem) => {
				if (cartItem.count > 0) {
					bundles++;
				}
				return bundles;
			}, 0);
		}

		findLicense(productId) {
			for (const license of this.#licenses) {
				if (license.productId === productId) {
					return license;
				}
			}
			return null;
		}

		get arkLicense() {
			return this.findLicense(Products?.Ark?.Base?.ProductId);
		}

		get arkSALicense() {
			return this.findLicense(Products?.ArkSA?.Base?.ProductId);
		}

		get ark2License() {
			return null;
		}

		get personalCartItem() {
			for (const cartItem of this.#items) {
				if (cartItem.isGift === false) {
					return cartItem;
				}
			}
			return null;
		}

		get total() {
			let total = 0;
			for (const cartItem of this.#items) {
				total += cartItem.total;
			}
			return total;
		}
	}
	const cart = BeaconCart.load();

	class ViewManager {
		#history = [];
		#timeout = null;

		constructor(initialView) {
			this.#history.push(initialView);
		}

		get currentView() {
			return this.#history.slice(-1);
		}

		back(animated = true) {
			if (this.#history.length <= 1) {
				return false;
			}

			this.switchView(this.#history[this.#history.length - 2], animated);
			this.#history = this.#history.slice(0, this.#history.length - 2);
			return true;
		}

		clearHistory() {
			if (this.#history.length <= 1) {
				return;
			}

			this.#history = this.#history.slice(-1);
		}

		switchView(newView, animated = true) {
			if (this.currentView === newView) {
				return;
			}

			if (this.#timeout) {
				clearTimeout(this.#timeout);
				this.#timeout = null;
			}

			const currentElement = document.getElementById(this.currentView);
			const newElement = document.getElementById(newView);
			this.#history.push(newView);

			if (animated) {
				currentElement.classList.add('invisible');
				this.#timeout = setTimeout(() => {
					currentElement.classList.add('hidden');
					newElement.classList.remove('hidden');
					this.#timeout = setTimeout(() => {
						newElement.classList.remove('invisible');
						this.#timeout = null;
					}, 150);
				}, 150);
			} else {
				currentElement.classList.add('hidden');
				currentElement.classList.add('invisible');
				newElement.classList.remove('invisible');
				newElement.classList.remove('hidden');
			}
		}
	}
	new ViewManager('checkout-wizard-start');
	const storeViewManager = new ViewManager('page-landing');

	const buyButton = document.getElementById('buy-button');
	const landingButton = document.getElementById('cart-back-button');
	const arkOnlyMode = Object.keys(ProductIds).length === 1;

	const goToCart = () => {
		history.pushState({}, '', '/omni#checkout');
		dispatchEvent(new PopStateEvent('popstate', {}));
	};

	const goToLanding = () => {
		history.pushState({}, '', '/omni');
		dispatchEvent(new PopStateEvent('popstate', {}));
	};

	const emailDialog = {
		cancelButton: document.getElementById('checkout-email-cancel'),
		actionButton: document.getElementById('checkout-email-action'),
		emailField: document.getElementById('checkout-email-field'),
		errorField: document.getElementById('checkout-email-error'),
		allowsSkipping: false,
		successFunction: function(cartChanged) {},
		init: function() {
			const actionFunction = (email) => {
				this.actionButton.disabled = true;
				this.cancelButton.disabled = true;
				this.errorField.classList.add('hidden');

				cart.setEmail(email).then(({newEmail, cartChanged}) => {
					BeaconDialog.hideModal();
					setTimeout(() => {
						this.successFunction(cartChanged);
					}, 310);
				}).catch((reason) => {
					this.errorField.innerText = reason;
					this.errorField.classList.remove('hidden');
				}).finally(() => {
					this.actionButton.disabled = false;
					this.cancelButton.disabled = false;
				});
			};

			this.actionButton.addEventListener('click', (ev) => {
				ev.preventDefault();

				actionFunction(this.emailField.value);
			});

			this.cancelButton.addEventListener('click', (ev) => {
				ev.preventDefault();

				if (this.allowsSkipping) {
					actionFunction(null);
					return;
				}

				BeaconDialog.hideModal();
			});
		},
		present: function(allowSkipping, successFunction) {
			if (checkoutProperties.forceEmail) {
				cart.setEmail(checkoutProperties.forceEmail).then(({newEmail, cartChanged}) => {
					successFunction(cartChanged);
				});
				return;
			}

			this.allowsSkipping = allowSkipping;
			this.successFunction = successFunction;

			if (cart.email) {
				this.emailField.value = cart.email;
			} else {
				this.emailField.value = sessionStorage.getItem('email') || localStorage.getItem('email') || '';
			}

			if (allowSkipping) {
				this.cancelButton.innerText = 'Skip For Now';
			} else {
				this.cancelButton.innerText = 'Cancel';
			}

			BeaconDialog.showModal('checkout-email');
		},
	};
	emailDialog.init();

	const wizard = {
		cartView: null,
		editCartItem: null,
		cancelButton: document.getElementById('checkout-wizard-cancel'),
		actionButton: document.getElementById('checkout-wizard-action'),
		giftCheck: document.getElementById('checkout-wizard-gift-check'),
		arkSACheck: document.getElementById('checkout-wizard-arksa-check'),
		arkCheck: document.getElementById('checkout-wizard-ark-check'),
		arkPriceField: document.getElementById('checkout-wizard-ark-price'),
		arkSAPriceField: document.getElementById('checkout-wizard-arksa-full-price'),
		arkSAUpgradePriceField: document.getElementById('checkout-wizard-arksa-discount-price'),
		arkSAStatusField: document.getElementById('checkout-wizard-status-arksa'),
		arkStatusField: document.getElementById('checkout-wizard-status-ark'),
		arkSADurationGroup: document.getElementById('checkout-wizard-arksa-duration-group'),
		arkSADurationField: document.getElementById('checkout-wizard-arksa-duration-field'),
		arkSADurationUpButton: document.getElementById('checkout-wizard-arksa-yearup-button'),
		arkSADurationDownButton: document.getElementById('checkout-wizard-arksa-yeardown-button'),
		arkSAPromoField: document.getElementById('checkout-wizard-promo-arksa'),
		arkOnlyCheck: document.getElementById('storefront-ark-check'),
		arkOnlyGiftField: document.getElementById('storefront-ark-gift-field'),
		arkOnlyOwnedField: document.getElementById('storefront-ark-owned'),
		arkOnlyGiftQuantityGroup: document.getElementById('storefront-ark-gift-group'),
		arkOnlyGiftUpButton: document.getElementById('storefront-ark-gift-increase'),
		arkOnlyGiftDownButton: document.getElementById('storefront-ark-gift-decrease'),
		init: function(cartView) {
			this.cartView = cartView;

			if (this.cancelButton) {
				this.cancelButton.addEventListener('click', (ev) => {
					ev.preventDefault();
					BeaconDialog.hideModal();
				});
			}

			if (this.actionButton) {
				this.actionButton.addEventListener('click', (ev) => {
					ev.preventDefault();

					const isGift = this.giftCheck.checked;
					const includeArk = this.arkCheck && this.arkCheck.disabled === false && this.arkCheck.checked;
					const includeArkSA = this.arkSACheck && this.arkSACheck.disabled === false && this.arkSACheck.checked;

					if ((includeArk || includeArkSA) === false) {
						return;
					}

					const arkSAYears = includeArkSA ? (parseInt(this.arkSADurationField.value) || 1) : 0;

					let lineItem;
					if (this.editCartItem) {
						lineItem = this.editCartItem;
					} else {
						lineItem = new BeaconCartItem();
						lineItem.isGift = isGift;
					}

					lineItem.build(cart, isGift, includeArk, arkSAYears);

					if (Boolean(this.editCartItem) === false) {
						const personalCartItem = cart.personalCartItem;
						if (isGift === false && Boolean(personalCartItem) === true) {
							personalCartItem.consume(cart, lineItem);
						} else {
							cart.add(lineItem);
						}
					}

					cart.save();
					this.cartView.update();
					goToCart();

					BeaconDialog.hideModal();
				});
			}

			if (this.giftCheck) {
				this.giftCheck.addEventListener('change', () => {
					this.update();
				});
			}

			if (this.arkCheck) {
				this.arkCheck.addEventListener('change', () => {
					this.update();
				});
			}

			if (this.arkSACheck && this.arkSADurationField && this.arkSADurationUpButton && this.arkSADurationDownButton && this.arkSADurationGroup) {
				this.arkSACheck.addEventListener('change', () => {
					this.update();
				});

				this.arkSADurationField.addEventListener('input', () => {
					this.update();
				});

				const nudgeArkSADuration = (amount) => {
					const originalValue = parseInt(this.arkSADurationField.value);
					let newValue = originalValue + amount;
					if (newValue > MaxRenewalCount || newValue < 1) {
						this.arkSADurationGroup.classList.add('shake');
						setTimeout(() => {
							this.arkSADurationGroup.classList.remove('shake');
						}, 400);
						newValue = Math.max(Math.min(newValue, MaxRenewalCount), 1);
					}
					if (originalValue !== newValue) {
						this.arkSADurationField.value = newValue;
						this.arkSACheck.checked = true;
						this.update();
					}
				};

				this.arkSADurationUpButton.addEventListener('click', (ev) => {
					ev.preventDefault();
					nudgeArkSADuration(1);
				});

				this.arkSADurationDownButton.addEventListener('click', (ev) => {
					ev.preventDefault();
					nudgeArkSADuration(-1);
				});
			}

			if (this.arkOnlyCheck) {
				this.arkOnlyCheck.addEventListener('change', (ev) => {
					ev.preventDefault();

					if (ev.currentTarget.checked) {
						let cartItem = cart.personalCartItem;
						if (!cartItem) {
							cartItem = new BeaconCartItem();
							cart.add(cartItem);
						}
						cartItem.build(cart, false, true, 0);
						cart.save();
					} else {
						const cartItem = cart.personalCartItem;
						if (cartItem) {
							cart.remove(cartItem);
						}
					}

					this.cartView.update();
				});
			}

			if (this.arkOnlyGiftField) {
				const updateCartArkGiftBundles = (desiredQuantity) => {
					const items = cart.items.filter((cartItem) => {
						return cartItem.isGift === true && cartItem.hasArk;
					});

					if (items.length === desiredQuantity) {
						return;
					} else if (items.length > desiredQuantity) {
						for (let idx = desiredQuantity; idx <= items.length - 1; idx++) {
							cart.remove(items[idx]);
						}
					} else if (items.length < desiredQuantity) {
						for (let idx = items.length; idx < desiredQuantity; idx++) {
							const cartItem = new BeaconCartItem;
							cartItem.build(cart, true, true, 0);
							cart.add(cartItem);
						}
					}

					this.cartView.update();
				};

				this.arkOnlyGiftField.addEventListener('input', (ev) => {
					const desiredQuantity = Math.min(Math.max(parseInt(ev.currentTarget.value), 0), MaxRenewalCount);
					updateCartArkGiftBundles(desiredQuantity);
				});

				this.arkOnlyGiftField.addEventListener('blur', () => {
					this.cartView.update();
				});

				const nudgeArkOnlyGiftQuantity = (amount) => {
					const originalValue = parseInt(this.arkOnlyGiftField.value);
					let newValue = originalValue + amount;
					if (newValue > MaxRenewalCount || newValue < 0) {
						this.arkOnlyGiftQuantityGroup.classList.add('shake');
						setTimeout(() => {
							this.arkOnlyGiftQuantityGroup.classList.remove('shake');
						}, 400);
						newValue = Math.max(Math.min(newValue, MaxRenewalCount), 0);
					}
					if (originalValue !== newValue) {
						this.arkOnlyGiftField.value = newValue;
						updateCartArkGiftBundles(newValue);
					}
				};

				this.arkOnlyGiftUpButton.addEventListener('click', (ev) => {
					ev.preventDefault();
					nudgeArkOnlyGiftQuantity(1);
				});

				this.arkOnlyGiftDownButton.addEventListener('click', (ev) => {
					ev.preventDefault();
					nudgeArkOnlyGiftQuantity(-1);
				});
			}
		},
		present: function(editCartItem = null) {
			this.editCartItem = editCartItem;
			this.arkCheck.disabled = false; // update() will disable them
			if (this.arkSACheck) {
				this.arkSACheck.disabled = false;
			}

			if (editCartItem) {
				this.giftCheck.checked = editCartItem.isGift;
				this.giftCheck.disabled = true;
				this.arkCheck.checked = editCartItem.hasArk;
				if (this.arkSACheck) {
					this.arkSACheck.checked = editCartItem.hasArkSA;
				}
			} else {
				this.giftCheck.checked = false;
				this.giftCheck.disabled = false;
				this.arkCheck.checked = false;
				if (this.arkSACheck) {
					this.arkSACheck.checked = false;
				}
			}

			if (this.arkSADurationField) {
				if (editCartItem) {
					this.arkSADurationField.value = editCartItem.arkSAYears;
				} else {
					this.arkSADurationField.value = '1';
				}
			}

			this.cancelButton.innerText = 'Cancel';
			this.update();

			BeaconDialog.showModal('checkout-wizard');
		},
		getGameStatus: function() {
			const gameStatus = {
				Ark: StatusNone,
				ArkSA: StatusNone,
			};

			const personalCartItem = cart.personalCartItem;
			const isEditing = Boolean(this.editCartItem);
			const isGift = this.giftCheck && this.giftCheck.checked;
			if (isGift) {
				gameStatus.Ark = this.arkCheck && this.arkCheck.disabled === false && this.arkCheck.checked ? StatusBuying : StatusNone;
				gameStatus.ArkSA = this.arkSACheck && this.arkSACheck.disabled === false && this.arkSACheck.checked ? StatusBuying : StatusNone;
			} else {
				if (cart.arkLicense) {
					gameStatus.Ark = StatusOwns;
				} else if (personalCartItem && (isEditing === false || personalCartItem.id !== this.editCartItem.id) && personalCartItem.hasArk) {
					gameStatus.Ark = StatusInCart;
				} else if (this.arkCheck && this.arkCheck.disabled === false && this.arkCheck.checked) {
					gameStatus.Ark = StatusBuying;
				} else {
					gameStatus.Ark = StatusNone;
				}

				if (cart.arkSALicense) {
					gameStatus.ArkSA = StatusOwns;
				} else if (personalCartItem && (isEditing === false || personalCartItem.id !== this.editCartItem.id) && personalCartItem.hasArkSA) {
					gameStatus.ArkSA = StatusInCart;
				} else if (this.arkSACheck && this.arkSACheck && this.arkSACheck.disabled === false && this.arkSACheck.checked) {
					gameStatus.ArkSA = StatusBuying;
				} else {
					gameStatus.ArkSA = StatusNone;
				}
			}

			return gameStatus;
		},
		update: function() {
			const gameStatus = this.getGameStatus();

			let total = 0;
			if (this.arkCheck && this.arkCheck.disabled === false && this.arkCheck.checked === true) {
				total = total + Products.Ark.Base.Price;
			}

			if (this.arkSACheck) {
				let arkSAFullPrice = Products.ArkSA.Base.Price;
				let arkSAEffectivePrice = Products.ArkSA.Base.Price;

				const arkSAYears = Math.min(Math.max(parseInt(this.arkSADurationField.value) || 1, 1), MaxRenewalCount);
				if (parseInt(this.arkSADurationField.value) !== arkSAYears && document.activeElement !== this.arkSADurationField) {
					this.arkSADurationField.value = arkSAYears;
				}
				const arkSAAdditionalYears = Math.max(arkSAYears - 1, 0);

				const discount = Math.round(((Products.ArkSA.Base.Price - Products.ArkSA.Upgrade.Price) / Products.ArkSA.Base.Price) * 100);
				this.arkSAPromoField.innerText = `${discount}% off first year when bundled with ${Products.Ark.Base.Name}`;

				if (gameStatus.ArkSA === StatusOwns) {
					// Show as renewal
					const license = cart.arkSALicense;
					const now = Math.floor(Date.now() / 1000);
					const currentExpiration = license.expiresEpoch;
					const currentExpirationDisplay = formatDate(epochToDate(currentExpiration), false);
					const startEpoch = (now > currentExpiration) ? ((Math.floor(now / 86400) * 86400) + 86400) : currentExpiration;
					const newExpiration = startEpoch + (Products.ArkSA.Renewal.PlanLengthSeconds * arkSAYears);
					const newExpirationDisplay = formatDate(epochToDate(newExpiration), false);

					let statusHtml;
					if (now > currentExpiration) {
						statusHtml = `Renew your update plan<br>Expired on <span class="text-red">${currentExpirationDisplay}</span><br>New expiration: <span class="text-green">${newExpirationDisplay}</span>`;
					} else {
						statusHtml = `Extend your update plan<br>Expires on <span class="text-green">${currentExpirationDisplay}</span><br>New expiration: <span class="text-green">${newExpirationDisplay}</span>`;
					}
					this.arkSAStatusField.innerHTML = statusHtml;

					arkSAFullPrice = Products.ArkSA.Renewal.Price * arkSAYears;
					arkSAEffectivePrice = arkSAFullPrice;
					this.arkSAPromoField.innerText = '';
					this.arkSAPromoField.classList.add('hidden');
				} else if (gameStatus.ArkSA === StatusInCart) {
					// Show as renewal
					arkSAFullPrice = Products.ArkSA.Renewal.Price * arkSAYears;
					arkSAEffectivePrice = arkSAFullPrice;
					this.arkSAStatusField.innerText = `Additional renewal years for ${Products.ArkSA.Base.Name} in your cart.`;
					this.arkSAPromoField.innerText = '';
					this.arkSAPromoField.classList.add('hidden');
				} else if (gameStatus.Ark !== StatusNone) {
					// Show as upgrade
					arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
					arkSAEffectivePrice = Products.ArkSA.Upgrade.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);

					const discountLanguage = gameStatus.Ark === StatusOwns ? 'because you own' : 'when bundled with';
					this.arkSAStatusField.innerText = `Includes first year of app updates. Additional years cost ${formatCurrency(Products.ArkSA.Renewal.Price)} each.`;
					this.arkSAPromoField.innerText = `${discount}% off first year ${discountLanguage} ${Products.Ark.Base.Name}`;
					this.arkSAPromoField.classList.remove('hidden');
				} else {
					// Show normal
					this.arkSAStatusField.innerText = `Includes first year of app updates. Additional years cost ${formatCurrency(Products.ArkSA.Renewal.Price)} each.`;
					this.arkSAPromoField.innerText = `${discount}% off first year when bundled with ${Products.Ark.Base.Name}`;
					this.arkSAPromoField.classList.remove('hidden');

					arkSAFullPrice = Products.ArkSA.Base.Price + (Products.ArkSA.Renewal.Price * arkSAAdditionalYears);
					arkSAEffectivePrice = arkSAFullPrice;
				}

				this.arkSAPriceField.classList.toggle('checkout-wizard-discounted', arkSAFullPrice !== arkSAEffectivePrice);
				this.arkSAPriceField.innerText = formatCurrency(arkSAFullPrice);
				this.arkSAUpgradePriceField.classList.toggle('hidden', arkSAFullPrice === arkSAEffectivePrice);
				this.arkSAUpgradePriceField.innerText = formatCurrency(arkSAEffectivePrice);

				if (this.arkSACheck.disabled === false && this.arkSACheck.checked === true) {
					total = total + arkSAEffectivePrice;
				}
			}

			if (gameStatus.Ark === StatusOwns) {
				this.arkStatusField.innerText = `You already own ${Products.Ark.Base.Name}.`;
				this.arkCheck.disabled = true;
				this.arkCheck.checked = false;
			} else if (gameStatus.Ark === StatusInCart) {
				this.arkStatusField.innerText = `${Products.Ark.Base.Name} is already in your cart.`;
				this.arkCheck.disabled = true;
				this.arkCheck.checked = false;
			} else {
				this.arkStatusField.innerText = 'Includes lifetime app updates.';
				this.arkCheck.disabled = false;
			}

			const addToCart = (this.editCartItem) ? 'Edit' : 'Add to Cart';
			if (total > 0) {
				this.actionButton.disabled = false;
				this.actionButton.innerText = `${addToCart}: ${formatCurrency(total)}`;
			} else {
				this.actionButton.disabled = true;
				this.actionButton.innerText = addToCart;
			}
		},
	};

	const cartView = {
		wizard: null,
		emailField: document.getElementById('storefront-cart-header-email-field'),
		changeEmailButton: document.getElementById('storefront-cart-header-email-button'),
		currencyMenu: document.getElementById('storefront-cart-currency-menu'),
		addMoreButton: document.getElementById('storefront-cart-more-button'),
		checkoutButton: document.getElementById('storefront-cart-checkout-button'),
		refundCheckbox: document.getElementById('storefront-refund-checkbox'),
		footer: document.getElementById('storefront-cart-footer'),
		body: document.getElementById('storefront-cart'),
		totalField: document.getElementById('storefront-cart-total'),
		init: function(wizard) {
			this.wizard = wizard;

			this.currencyMenu.addEventListener('change', (ev) => {
				ev.preventDefault();

				BeaconWebRequest.get(`/omni/currency?currency=${ev.target.value}`).then(() => {
					window.location.reload();
				}).catch((error) => {
					console.log(JSON.stringify(error));
					BeaconDialog.show('Currency was not changed', error.statusText);
				});
			});

			this.addMoreButton.addEventListener('click', (ev) => {
				ev.preventDefault();

				this.wizard.present();
			});

			this.checkoutButton.addEventListener('click', (ev) => {
				ev.preventDefault();

				const refundPolicyAgreed = this.refundCheckbox.checked;
				const checkoutFunction = (cartChanged) => {
					this.update();
					if (cartChanged) {
						if (cart.count > 0) {
							BeaconDialog.show('Your cart contents have changed.', 'The items in your cart have changed based on your e-mail address. Please review before continuing checkout.');
						} else {
							BeaconDialog.show('Your cart is now empty.', 'You already own everything in your cart. There is no need to purchase again.');
						}
						return;
					}

					this.checkoutButton.disabled = true;

					BeaconWebRequest.post('/omni/begin', {...cart.toJSON(), refundPolicyAgreed}).then((response) => {
						try {
							const parsed = JSON.parse(response.body);
							const url = parsed.url;
							sessionStorage.setItem('clientReferenceId', parsed.client_reference_id);
							window.location = url;
						} catch (err) {
							console.log(response.body);
							BeaconDialog.show('Unknown Error', 'There was an unknown error while starting the checkout process.');
						}
					}).catch((error) => {
						try {
							const parsed = JSON.parse(error.body);
							const message = parsed.message;
							BeaconDialog.show('Checkout Error', message);
						} catch (err) {
							console.log(error.body);
							BeaconDialog.show('Unknown Error', 'There was an unknown error while starting the checkout process.');
						}
					}).finally(() => {
						this.checkoutButton.disabled = false;
					});
				};

				if (!cart.email) {
					emailDialog.present(false, checkoutFunction);
				} else if (!refundPolicyAgreed) {
					BeaconDialog.show('Hang on', 'Please agree to the refund policy.');
				} else {
					checkoutFunction(false);
				}
			});

			this.changeEmailButton.addEventListener('click', (ev) => {
				ev.preventDefault();

				emailDialog.present(false, () => {
					this.update();
				});
			});

			this.update();
		},
		update: function() {
			if (arkOnlyMode) {
				this.emailField.innerText = cart.email;
				this.changeEmailButton.disabled = Boolean(checkoutProperties.forceEmail);
				this.changeEmailButton.innerText = cart.email ? 'Change Email' : 'Set Email';
				this.changeEmailButton.classList.remove('hidden');
				this.addMoreButton.classList.add('hidden');

				if (cart.arkLicense) {
					this.wizard.arkOnlyOwnedField.classList.remove('hidden');
					this.wizard.arkOnlyCheck.parentElement.classList.add('hidden');
				} else {
					this.wizard.arkOnlyOwnedField.classList.add('hidden');
					this.wizard.arkOnlyCheck.parentElement.classList.remove('hidden');
				}

				const personalCartItem = cart.personalCartItem;
				this.wizard.arkOnlyCheck.checked = personalCartItem && personalCartItem.hasArk;

				if (document.activeElement !== this.wizard.arkOnlyGiftField) {
					const giftItems = cart.items.filter((cartItem) => {
						return cartItem.isGift === true && cartItem.hasArk;
					});

					this.wizard.arkOnlyGiftField.value = giftItems.length;
				}
			} else if (cart.count > 0) {
				this.emailField.innerText = cart.email;
				this.changeEmailButton.disabled = Boolean(checkoutProperties.forceEmail);
				this.changeEmailButton.innerText = cart.email ? 'Change Email' : 'Set Email';
				this.changeEmailButton.classList.remove('hidden');
				this.body.innerText = '';
				this.body.classList.remove('empty');
				this.footer.classList.remove('hidden');

				const items = cart.items;
				items.forEach((cartItem) => {
					const bundleRow = this.createCartItemRow(cartItem);
					if (bundleRow) {
						this.body.appendChild(bundleRow);
					}
				});

				buyButton.innerText = 'Go to Cart';
			} else {
				this.emailField.innerText = '';
				this.changeEmailButton.classList.add('hidden');
				this.body.innerText = '';
				this.body.classList.add('empty');
				this.footer.classList.add('hidden');
				this.body.appendChild(document.createElement('div'));

				const middleCell = document.createElement('div');
				const firstParagraph = document.createElement('p');
				firstParagraph.appendChild(document.createTextNode('Your cart is empty.'));
				middleCell.appendChild(firstParagraph);

				this.buyMoreButton = document.createElement('button');
				this.buyMoreButton.addEventListener('click', () => {
					emailDialog.present(true, () => {
						this.wizard.present();
					});
				});
				this.buyMoreButton.classList.add('default');
				this.buyMoreButton.appendChild(document.createTextNode('Buy Omni'));
				const secondParagraph = document.createElement('p');
				secondParagraph.appendChild(this.buyMoreButton);
				middleCell.appendChild(secondParagraph);

				this.body.appendChild(middleCell);

				this.body.appendChild(document.createElement("div"));

				buyButton.innerText = 'Buy Omni';
			}

			this.totalField.setAttribute('beacon-price', cart.total);
			formatPrices(checkoutProperties.currencyCode);

			this.checkoutButton.disabled = (cart.total === 0);
		},
		createProductRow: function(cartItem, productId) {
			const quantity = cartItem.getQuantity(productId);
			if (quantity <= 0) {
				return null;
			}

			const name = ProductIds[productId].Name;
			const price = ProductIds[productId].Price;

			const quantityCell = document.createElement('div');
			quantityCell.appendChild(document.createTextNode(quantity));

			const nameCell = document.createElement('div');
			nameCell.appendChild(document.createTextNode(name));

			const priceCell = document.createElement('div');
			priceCell.classList.add('formatted-price');
			priceCell.appendChild(document.createTextNode(price * quantity));

			const row = document.createElement('div');
			row.classList.add('bundle-product');
			row.appendChild(quantityCell);
			row.appendChild(nameCell);
			row.appendChild(priceCell);

			return row;
		},
		createCartItemRow: function(cartItem) {
			const productIds = cartItem.productIds;
			if (productIds.length <= 0) {
				return null;
			}

			const row = document.createElement('div');
			row.classList.add('bundle');
			productIds.forEach((productId) => {
				const productRow = this.createProductRow(cartItem, productId);
				if (productRow) {
					row.appendChild(productRow);
				}
			});

			const giftCell = document.createElement('div');
			if (cartItem.isGift) {
				row.classList.add('gift');

				giftCell.classList.add('gift');
				if (productIds.length > 1) {
					giftCell.appendChild(document.createTextNode('These products are a gift. You will receive a gift code for them.'));
				} else {
					giftCell.appendChild(document.createTextNode('This product is a gift. You will receive a gift code for it.'));
				}
			}

			const editButton = document.createElement('button');
			editButton.appendChild(document.createTextNode('Edit'));
			editButton.classList.add('small');
			editButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				this.wizard.present(cartItem);
			});

			const removeButton = document.createElement('button');
			removeButton.appendChild(document.createTextNode('Remove'));
			removeButton.classList.add('red');
			removeButton.classList.add('small');
			removeButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				cart.remove(cartItem);
				this.update();
			});

			const actionButtons = document.createElement('div');
			actionButtons.classList.add('button-group');
			actionButtons.appendChild(editButton);
			actionButtons.appendChild(removeButton);

			const actionsCell = document.createElement('div');
			actionsCell.appendChild(actionButtons);

			const actionsRow = document.createElement('div');
			actionsRow.classList.add('actions');
			actionsRow.classList.add('double-group');
			actionsRow.appendChild(giftCell);
			actionsRow.appendChild(actionsCell);

			row.appendChild(actionsRow);

			return row;
		},
	};
	wizard.init(cartView);
	cartView.init(wizard);

	const setViewMode = (animated = true) => {
		window.scrollTo(window.scrollX, 0);
		if (window.location.hash === '#checkout') {
			storeViewManager.switchView('page-cart', animated);
		} else {
			storeViewManager.back(animated);
		}
	};

	buyButton.addEventListener('click', (ev) => {
		ev.preventDefault();

		if (arkOnlyMode || cart.count > 0) {
			goToCart();
			return;
		}

		emailDialog.present(true, () => {
			wizard.present();
		});
	});

	landingButton.addEventListener('click', () => {
		goToLanding();
	});

	window.addEventListener('popstate', () => {
		setViewMode(true);
	});
	setViewMode(false);

	if (checkoutProperties.forceEmail) {
		if (cart.email !== checkoutProperties.forceEmail) {
			cart.reset();
		}
		if (cart.count === 0) {
			emailDialog.present(true, () => {
				wizard.present();
			});
		} else {
			goToCart();
		}
	}
});
