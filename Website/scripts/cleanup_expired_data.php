#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$database->BeginTransaction();
$database->Query("DELETE FROM public.access_tokens WHERE refresh_token_expiration < CURRENT_TIMESTAMP;");
$database->Query("DELETE FROM public.application_auth_flows WHERE expiration < CURRENT_TIMESTAMP;");
$database->Query("DELETE FROM public.oauth_requests WHERE expiration < CURRENT_TIMESTAMP;");
$database->Commit();

// Cleanup and renew tokens
BeaconAPI\v4\ServiceToken::RefreshExpiring();

echo "Expired data has been cleaned.\n";
exit;

?>
