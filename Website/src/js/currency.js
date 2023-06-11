"use strict";

class BeaconCurrency {
	static #globalize = null;
	static #formatters = {};
	static #currencyCode = 'USD';
	static #defaultFormatter = null;
	
	static get currencyCode() {
		return this.#currencyCode;
	}
	
	static set currencyCode(newCurrencyCode) {
		this.#currencyCode = newCurrencyCode;
		this.#defaultFormatter = this.getFormatter(newCurrencyCode);
	}
	
	static getFormatter(currencyCode) {
		if (!this.#formatters[currencyCode] && this.#globalize) {
			this.#formatters[currencyCode] = this.#globalize.currencyFormatter(currencyCode);
		}
		return this.#formatters[currencyCode];
	}
	
	static get defaultFormatter() {
		return this.#defaultFormatter;
	}
	
	static load() {
		const dataFiles = [
			'supplemental/likelySubtags.json',
			'main/en/numbers.json',
			'supplemental/numberingSystems.json',
			'supplemental/plurals.json',
			'supplemental/ordinals.json',
			'main/en/currencies.json',
			'supplemental/currencyData.json'
		];
		const dataPromises = [];
		for (const dataFile of dataFiles) {
			dataPromises.push(BeaconWebRequest.get(`/assets/scripts/cldr/${dataFile}`).then((response) => {
				try {
					Globalize.load(JSON.parse(response.body));
				} catch (loadErr) {
					console.log(loadErr);
				}
			}).catch((err) => {
				console.log(`Error: ${err.statusText}`);
			}));
		}
		Promise.all(dataPromises).then(() => {
			this.#globalize = Globalize('en');
			if (this.#currencyCode && !this.#defaultFormatter) {
				this.#defaultFormatter = this.getFormatter(this.#currencyCode);
			}
			
			
			this.formatPrices();
			
			document.dispatchEvent(new Event('GlobalizeLoaded'));
		});
	}
	
	static formatPrices() {
		const prices = document.querySelectorAll('.formatted-price');
		prices.forEach((elem) => {
			const price = parseFloat(elem.getAttribute('beacon-price') ?? elem.innerText);
			const currency = elem.getAttribute('beacon-currency');
			const formatter = currency ? BeaconCurrency.getFormatter(currency) : BeaconCurrency.defaultFormatter;
			if (formatter) {
				elem.innerText = formatter(price);
			}
		});
	}
}

document.addEventListener('DOMContentLoaded', () => {
	BeaconCurrency.load();
});
