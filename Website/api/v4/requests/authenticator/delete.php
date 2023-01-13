<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user = BeaconAPI::User();
	$user_id = $user->UserID();
	$authenticator_id = $context['path_parameters']['authenticator_id'];
	$authenticator = Authenticator::GetByAuthenticatorID($authenticator_id);
	if ($authenticator && $authenticator->UserID() === $user_id) {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$authenticator->Delete();
		if ($user->Is2FAProtected() === false) {
			$user->Clear2FABackupCodes(true);
		}
		$database->Commit();
		BeaconAPI::ReplySuccess('Authenticator was deleted.');
	} else {
		BeaconAPI::ReplyError('Authenticator not found', null, 404);
	}
}

?>