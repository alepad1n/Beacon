<?php

// This file is for a "hard" password reset, for when the user forgets their password

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\{Response, EmailVerificationCode, Session, User, UserGenerator};

define('ERR_EMAIL_NOT_VERIFIED', 436);
define('ERR_PASSWORD_VIOLATES_RULES', 437);
define('ERR_PASSWORD_COMPROMISED', 438);
define('ERR_CONFIRM_CHILD_RESET', 439);

if (empty($_POST['email']) || empty($_POST['password']) || empty($_POST['code'])) {
	Response::NewJsonError('Missing parameters.', null, 400)->Flush();
	exit;
}

$email = $_POST['email'];
$password = $_POST['password'];
$code = $_POST['code'];
$username = trim($_POST['username'] ?? ''); // only used for new accounts
$allow_vulnerable = filter_var($_POST['allow_vulnerable'] ?? false, FILTER_VALIDATE_BOOLEAN);
	
$verification = EmailVerificationCode::Fetch($email, $code);
if (is_null($verification)) {
	Response::NewJsonError('Email not verified.', null, ERR_EMAIL_NOT_VERIFIED)->Flush();
	exit;
}

// make sure the password is a good password
if (User::ValidatePassword($password) === false) {
	Response::NewJsonError('Password must be at least 8 characters and you should avoid repeating characters.', null, ERR_PASSWORD_VIOLATES_RULES)->Flush();
	exit;
}

// check the password against haveibeenpwned, only if not already checked
if ($allow_vulnerable == false) {
	$hash = strtolower(sha1($password));
	$prefix = substr($hash, 0, 5);
	$suffix = substr($hash, 5);
	$url = 'https://api.pwnedpasswords.com/range/' . $prefix;
	$hashes = explode("\n", file_get_contents($url));
	foreach ($hashes as $hash) {
		$count = intval(substr($hash, 36));
		$hash = strtolower(substr($hash, 0, 35));
		if ($hash == $suffix && $count > 0) {
			// vulnerable
			Response::NewJsonError('Password is listed as vulnerable according to haveibeenpwned.com.', null, ERR_PASSWORD_COMPROMISED)->Flush();
			exit;
		}
	}
}

$publicKeyPem = null;
$privateKeyPem = null;
BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);
	
$privateKeySalt = BeaconEncryption::GenerateSalt();
$privateKeyIterations = 100000;
$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
$privateKey = bin2hex(BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false));
$privateKeySalt = bin2hex($privateKeySalt);
$cloudKey = bin2hex(BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey()));

$userProperties = [
	'publicKey' => $publicKeyPem,
	'privateKey' => $privateKey,
	'privateKeySalt' => $privateKeySalt,
	'privateKeyIterations' => $privateKeyIterations,
	'cloudKey' => $cloudKey
];

$database = BeaconCommon::Database();
$database->BeginTransaction();

try {
	$sendWelcomeEmail = false;
	$user = User::Fetch($email);
	if (is_null($user)) {
		$userProperties['email'] = $email;
		$userProperties['username'] = $username;
		
		$user = UserGenerator::CreateNamed($email, $username, $password);
		$sendWelcomeEmail = true;
	} else {
		$secondFactorCode = $_POST['verification_code'] ?? '';
		if ($user->Is2FAProtected() && $user->Verify2FACode($secondFactorCode) === false) {
			$database->Rollback();
			
			Response::NewJsonError('Verification code required.', ['code' => '2FA_ENABLED'], 403)->Flush();
			exit;
		}
		
		UserGenerator::ReplacePassword($user, $password);
	}
	
	// Remove the verification codes for this user
	EmailVerificationCode::Clear($email);
	
	$database->Commit();
	
	if ($sendWelcomeEmail) {
		$subject = 'Welcome to Beacon';
		$body = "You just created a Beacon Account, which means you can easily share your documents with multiple devices. You can manage your account at <" . BeaconCommon::AbsoluteURL("/account/") . "> to change your password, manage documents, and see your Beacon Omni purchase status.\n\nFor reference, you can view Beacon's privacy policy at <" . BeaconCommon::AbsoluteURL("/privacy") . ">. The summary of it is simple: your data is yours and won't be sold or monetized in any way.\n\nHave fun and happy looting!\nThom McGrath, developer of Beacon.";
		BeaconEmail::SendMail($email, $subject, $body);
	}
	
	Response::NewJson([
		'userId' => $user->UserId()
	], 200)->Flush();
	exit;
} catch (Exception $err) {
	$database->Rollback();
	
	Response::NewJsonError($err->getMessage(), ['code' => '2FA_ENABLED'], 400)->Flush();
	exit;
}

?>