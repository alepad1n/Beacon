"use strict";

document.addEventListener('DOMContentLoaded', () => {
  var currentPage = '';
  var pages = ['login', 'totp', 'recover', 'verify', 'password', 'loading'];
  pages.forEach(pageName => {
    var element = document.getElementById("page_".concat(pageName));
    if (!element) {
      return;
    }
    if (!currentPage) {
      currentPage = pageName;
      return;
    }
    element.classList.add('hidden');
  });
  var showPage = newPage => {
    var fromElement = document.getElementById("page_".concat(currentPage));
    var toElement = document.getElementById("page_".concat(newPage));
    if (!(fromElement && toElement)) {
      return;
    }
    fromElement.classList.add('hidden');
    toElement.classList.remove('hidden');
    currentPage = newPage;
  };
  var focusFirst = function (fieldIds) {
    var requireEmpty = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : true;
    var focused = false;
    for (var fieldId of fieldIds) {
      var field = fieldId instanceof HTMLElement ? fieldId : document.getElementById(fieldId);
      if (field && (requireEmpty === false || field.value === '')) {
        field.focus();
        focused = true;
        break;
      }
    }

    // if we didn't focus on the first empty something, go back and focus on the first something
    if (focused === false && requireEmpty === true) {
      focusFirst(fieldIds, false);
    }
  };
  var knownVulnerablePassword = '';
  var loginPage = document.getElementById('page_login');
  var loginForm = document.getElementById('login_form_intro');
  var loginEmailField = document.getElementById('login_email_field');
  var loginPasswordField = document.getElementById('login_password_field');
  var loginRememberCheck = document.getElementById('login_remember_check');
  var loginReturnField = document.getElementById('login_return_field');
  var loginRecoverButton = document.getElementById('login_recover_button');
  var loginCancelButton = document.getElementById('login_cancel_button');
  var loginActionButton = document.getElementById('login_action_button');
  var loginExplicitEmailField = document.getElementById('login_explicit_email');
  var loginExplicitCodeField = document.getElementById('login_explicit_code');
  var loginExplicitPasswordField = document.getElementById('login_explicit_password');
  var totpPage = document.getElementById('page_totp');
  var totpForm = document.getElementById('login_form_totp');
  var totpCodeField = document.getElementById('totp_code_field');
  var totpRememberCheck = document.getElementById('totp_remember_check');
  var totpActionButton = document.getElementById('totp_action_button');
  var totpCancelButton = document.getElementById('totp_cancel_button');
  var recoverForm = document.getElementById('login_recover_form');
  var recoverEmailField = document.getElementById('recover_email_field');
  var recoverActionButton = document.getElementById('recover_action_button');
  var recoverCancelButton = document.getElementById('recover_cancel_button');
  var verifyForm = document.getElementById('login_verify_form');
  var verifyCodeField = document.getElementById('verify_code_field');
  var verifyEmailField = document.getElementById('verify_email_field');
  var verifyCancelButton = document.getElementById('verify_cancel_button');
  var verifyActionButton = document.getElementById('verify_action_button');
  var passwordPage = document.getElementById('page_password');
  var passwordForm = document.getElementById('login_password_form');
  var passwordEmailField = document.getElementById('password_email_field');
  var passwordCodeField = document.getElementById('password_code_field');
  var passwordUsernameField = document.getElementById('username_field');
  var passwordCancelButton = document.getElementById('password_cancel_button');
  var passwordUseSuggestedLink = document.getElementById('suggested-username-link');
  var passwordNewSuggestionLink = document.getElementById('new-suggestion-link');
  var passwordInitialField = document.getElementById('password_initial_field');
  var passwordConfirmField = document.getElementById('password_confirm_field');
  var passwordActionButton = document.getElementById('password_action_button');
  var passwordAuthenticatorCodeParagraph = document.getElementById('password_totp_paragraph');
  var passwordAuthenticatorCodeLabel = document.getElementById('password_totp_label');
  var passwordAuthenticatorCodeField = document.getElementById('password_totp_field');
  var loginReturnURI = loginReturnField ? loginReturnField.value : '';
  var loginRemember = false;
  var storedRemember = false;
  var storedEmail = null;
  var explicitEmail = loginExplicitEmailField ? loginExplicitEmailField.value : null;
  if (explicitEmail === null && localStorage) {
    storedEmail = localStorage.getItem('email');
    storedRemember = storedEmail !== null;
  }
  var consumeURI = passwordPage ? passwordPage.getAttribute('beacon-consumer-uri') : '';

  // !Login Page
  if (loginEmailField) {
    if (explicitEmail !== null) {
      loginEmailField.value = explicitEmail;
    } else if (storedRemember) {
      loginEmailField.value = storedEmail;
    }
  }
  if (loginRememberCheck) {
    loginRememberCheck.checked = storedRemember;
  }
  if (loginForm || totpForm) {
    var loginFunction = ev => {
      ev.preventDefault();
      if (!(loginEmailField && loginPasswordField)) {
        return false;
      }
      var loginEmail = loginEmailField.value.trim();
      var loginPassword = loginPasswordField.value;
      if (loginRememberCheck) {
        loginRemember = loginRememberCheck.checked;
      }
      if (loginRemember == false && localStorage) {
        localStorage.removeItem('email');
      }
      if (sessionStorage) {
        sessionStorage.removeItem('email');
      }
      if (loginEmail === '' || loginPassword.length < 8) {
        BeaconDialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
        return false;
      }
      showPage('loading');
      var sessionBody = {
        device_id: deviceId
      };
      var totpCode = totpCodeField.value.trim();
      if (Boolean(totpCode) === true) {
        sessionBody.verification_code = totpCode;
        sessionBody.trust = totpRememberCheck.value;
      }
      BeaconWebRequest.post("https://".concat(apiDomain, "/v3/session"), sessionBody, {
        Authorization: "Basic ".concat(btoa(loginEmail + ':' + loginPassword))
      }).then(response => {
        if (localStorage && loginRemember) {
          localStorage.setItem('email', loginEmail);
        }
        if (sessionStorage) {
          sessionStorage.setItem('email', loginEmail);
        }
        try {
          var obj = JSON.parse(response.body);
          var url = consumeURI;
          url = url.replace('{{session_id}}', encodeURIComponent(obj.session_id));
          url = url.replace('{{return_uri}}', encodeURIComponent(loginReturnURI));
          url = url.replace('{{user_password}}', encodeURIComponent(loginPassword));
          url = url.replace('{{temporary}}', loginRemember == false ? 'true' : 'false');
          window.location = url;
        } catch (e) {
          console.log(e);
        }
      }).catch(error => {
        console.log(JSON.stringify(error));
        switch (error.status) {
          case 401:
          case 403:
            try {
              var obj = JSON.parse(error.body);
              var code = obj.details.code;
              if (code === '2FA_ENABLED') {
                showPage('totp');
                focusFirst([totpCodeField]);
                break;
              }
            } catch (e) {}
            BeaconDialog.show('Incorrect Login', 'Email or password is not correct.').then(() => {
              showPage('login');
            });
            break;
          default:
            BeaconDialog.show('Unable to complete login', "Sorry, there was a ".concat(error.status, " error.")).then(() => {
              showPage('login');
            });
            break;
        }
      });
      return false;
    };
    if (loginForm) {
      loginForm.addEventListener('submit', loginFunction);
    }
    if (totpForm) {
      totpForm.addEventListener('submit', loginFunction);
    }
  }
  if (loginRecoverButton) {
    loginRecoverButton.addEventListener('click', ev => {
      ev.preventDefault();
      if (recoverEmailField && loginEmailField) {
        recoverEmailField.value = loginEmailField.value;
      }
      showPage('recover');
      focusFirst([recoverEmailField]);
      return false;
    });
  }
  if (loginCancelButton) {
    loginCancelButton.addEventListener('click', ev => {
      ev.preventDefault();
      window.location = 'beacon://dismiss_me';
      return false;
    });
  }
  if (totpCancelButton) {
    totpCancelButton.addEventListener('click', ev => {
      ev.preventDefault();
      showPage('login');
      focusFirst([loginPasswordField]);
    });
  }

  // !Recovery Page
  if (recoverForm) {
    recoverForm.addEventListener('submit', ev => {
      ev.preventDefault();
      if (recoverActionButton) {
        recoverActionButton.disabled = true;
      }
      if (!recoverEmailField) {
        console.log('Missing email field');
        return;
      }
      var params = new URLSearchParams();
      params.append('email', recoverEmailField.value.trim());
      BeaconWebRequest.post('/account/login/email', params).then(response => {
        try {
          var obj = JSON.parse(response.body);
          if (recoverActionButton) {
            recoverActionButton.disabled = false;
          }
          if (obj.verified) {
            if (passwordEmailField) {
              passwordEmailField.value = obj.email;
            }
            showPage('password');
            focusFirst([passwordInitialField, passwordConfirmField, passwordActionButton]);
          } else {
            if (verifyEmailField) {
              verifyEmailField.value = obj.email;
            }
            showPage('verify');
            focusFirst([verifyCodeField, verifyActionButton]);
          }
        } catch (e) {
          console.log(e);
        }
      }).catch(error => {
        console.log(JSON.stringify(error));
        if (recoverActionButton) {
          recoverActionButton.disabled = false;
        }
        var alert = {
          message: 'Unable to continue',
          explanation: "There was a ".concat(error.status, " error while trying to send the verification email.")
        };
        try {
          var obj = JSON.parse(error.body);
          if (obj.message) {
            alert.explanation = obj.message;
          }
        } catch (err) {
          console.log(err);
        }
        BeaconDialog.show(alert.message, alert.explanation).then(() => {
          showPage('recover');
        });
      });
      return false;
    });
  }
  if (recoverCancelButton) {
    recoverCancelButton.addEventListener('click', ev => {
      ev.preventDefault();
      showPage('login');
      focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
      return false;
    });
  }

  // !Address verification
  if (verifyForm) {
    verifyForm.addEventListener('submit', ev => {
      ev.preventDefault();
      if (!(verifyCodeField && verifyEmailField)) {
        console.log('Missing fields');
        return;
      }
      showPage('loading');
      var params = new URLSearchParams();
      params.append('email', verifyEmailField.value.trim());
      params.append('code', verifyCodeField.value.trim());
      BeaconWebRequest.post('/account/login/verify', params).then(response => {
        try {
          var obj = JSON.parse(response.body);
          if (obj.verified) {
            if (passwordEmailField && passwordCodeField) {
              passwordEmailField.value = obj.email;
              passwordCodeField.value = obj.code;
            }
            if (obj.username && passwordUsernameField) {
              passwordUsernameField.value = obj.username;
              passwordPage.className = 'as-recover-user';
            }
            showPage('password');
            focusFirst([passwordUsernameField, passwordInitialField, passwordConfirmField, passwordActionButton]);
          } else {
            BeaconDialog.show('Incorrect code', 'The code entered is not correct.').then(() => {
              showPage('verify');
              if (verifyCodeField) {
                verifyCodeField.value = '';
                verifyCodeField.focus();
              }
            });
          }
        } catch (e) {
          console.log(e);
        }
      }).catch(error => {
        console.log(JSON.stringify(error));
        BeaconDialog.show('Unable to confirm', "There was a ".concat(error.status, " error while trying to verify the code.")).then(() => {
          showPage('verify');
        });
      });
      return false;
    });
  }
  if (verifyCancelButton) {
    verifyCancelButton.addEventListener('click', ev => {
      ev.preventDefault();
      showPage('login');
      focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
      return false;
    });
  }

  // !Password form
  if (passwordForm) {
    var passwordConfirmChildrenReset = false;
    passwordForm.addEventListener('submit', ev => {
      ev.preventDefault();
      var passwordEmail = passwordEmailField ? passwordEmailField.value.trim() : '';
      var passwordVerificationCode = passwordCodeField ? passwordCodeField.value.trim() : '';
      var passwordUsername = passwordUsernameField ? passwordUsernameField.value : '';
      var passwordInitial = passwordInitialField ? passwordInitialField.value : '';
      var passwordConfirm = passwordConfirmField ? passwordConfirmField.value : '';
      var passwordAllowVulnerable = passwordInitial === knownVulnerablePassword;
      var passwordPrevious = loginExplicitPasswordField ? loginExplicitPasswordField.value : null;
      var passwordAuthenticatorCode = passwordAuthenticatorCodeField ? passwordAuthenticatorCodeField.value : '';
      if (passwordInitial.length < 8) {
        BeaconDialog.show('Password too short', 'Your password must be at least 8 characters long.');
        return false;
      }
      if (passwordInitial !== passwordConfirm) {
        BeaconDialog.show('Passwords do not match', 'Please make sure the two passwords match.');
        return false;
      }
      var form = new URLSearchParams();
      form.append('email', passwordEmail);
      form.append('username', passwordUsername);
      form.append('password', passwordInitial);
      form.append('code', passwordVerificationCode);
      form.append('allow_vulnerable', passwordAllowVulnerable);
      form.append('confirm_reset_children', passwordConfirmChildrenReset);
      form.append('verification_code', passwordAuthenticatorCode);
      if (passwordPrevious) {
        form.append('previous_password', passwordPrevious);
      }
      showPage('loading');
      BeaconWebRequest.post('/account/login/password', form).then(response => {
        try {
          var obj = JSON.parse(response.body);
          if (localStorage && loginRemember) {
            localStorage.setItem('email', passwordEmail);
          }
          var url = consumeURI;
          url = url.replace('{{session_id}}', encodeURIComponent(obj.session_id));
          url = url.replace('{{return_uri}}', encodeURIComponent(loginReturnURI));
          url = url.replace('{{user_password}}', encodeURIComponent(passwordInitial));
          url = url.replace('{{temporary}}', loginRemember === false ? 'false' : 'true');
          window.location = url;
        } catch (e) {
          console.log(e);
        }
      }).catch(error => {
        console.log(JSON.stringify(error));
        var dialog;
        try {
          var obj = JSON.parse(error.body);
          switch (error.status) {
            case 403:
              if (passwordAuthenticatorCodeParagraph) {
                if (passwordAuthenticatorCodeParagraph.classList.contains('hidden')) {
                  passwordAuthenticatorCodeParagraph.classList.remove('hidden');
                } else {
                  if (passwordAuthenticatorCodeLabel) {
                    passwordAuthenticatorCodeLabel.classList.add('invalid');
                    passwordAuthenticatorCodeLabel.innerText = 'Incorrect Code';
                  }
                  if (passwordAuthenticatorCodeField) {
                    passwordAuthenticatorCodeField.classList.add('invalid');
                  }
                  setTimeout(() => {
                    if (passwordAuthenticatorCodeLabel) {
                      passwordAuthenticatorCodeLabel.classList.remove('invalid');
                      passwordAuthenticatorCodeLabel.innerText = 'Two Step Verification Code';
                    }
                    if (passwordAuthenticatorCodeField) {
                      passwordAuthenticatorCodeField.classList.remove('invalid');
                    }
                  }, 3000);
                }
              }
              showPage('password');
              break;
            case 436:
            case 437:
              dialog = BeaconDialog.show('Unable to create Beacon account.', obj.message);
              break;
            case 438:
              knownVulnerablePassword = passwordInitial;
              dialog = BeaconDialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
              break;
            case 439:
              BeaconDialog.confirm('WARNING!', 'Your team members will be unable to sign into their accounts until you reset each of their passwords once you sign in. See the "Team" section of your Beacon account control panel.', 'Reset Password').then(() => {
                passwordConfirmChildrenReset = true;
                passwordForm.dispatchEvent(new Event('submit', {
                  'bubbles': true,
                  'cancelable': true
                }));
              }).catch(() => {
                showPage('password');
              });
              break;
            default:
              dialog = BeaconDialog.show('Unable to create user', "There was a ".concat(error.status, " error while trying to create your account."));
              break;
          }
          if (dialog) {
            dialog.then(() => {
              showPage('password');
            });
          }
        } catch (e) {
          console.log(e);
        }
      });
    });
  }
  if (passwordCancelButton) {
    passwordCancelButton.addEventListener('click', ev => {
      ev.preventDefault();
      showPage('login');
      focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
      return false;
    });
  }
  if (passwordUseSuggestedLink) {
    passwordUseSuggestedLink.addEventListener('click', ev => {
      ev.preventDefault();
      if (passwordUsernameField) {
        passwordUsernameField.value = ev.target.getAttribute('beacon-username');
      }
      return false;
    });
  }
  if (passwordNewSuggestionLink) {
    passwordNewSuggestionLink.addEventListener('click', ev => {
      BeaconWebRequest.get('/account/login/suggest').then(response => {
        try {
          var obj = JSON.parse(response.body);
          if (passwordUseSuggestedLink) {
            passwordUseSuggestedLink.innerText = obj.username;
            passwordUseSuggestedLink.setAttribute('beacon-username', obj.username);
          }
        } catch (e) {
          console.log(e);
        }
      }).catch(error => {
        console.log(JSON.stringify(error));
      });
      ev.preventDefault();
      return false;
    });
  }
  if (window.location.hash == '#create') {
    if (recoverEmailField && explicitEmail) {
      recoverEmailField.value = explicitEmail;
    }
    showPage('recover');
  } else if (loginExplicitEmailField && loginExplicitCodeField && verifyCodeField && verifyEmailField) {
    verifyEmailField.value = loginExplicitEmailField.value;
    verifyCodeField.value = loginExplicitCodeField.value;
    verifyForm.dispatchEvent(new Event('submit', {
      'bubbles': true,
      'cancelable': true
    }));
  }
  if (window.location.search !== '') {
    window.history.pushState({}, '', '/account/login/');
  }
});