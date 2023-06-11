<?php

$database = BeaconCommon::Database();
$licenses = $database->Query('SELECT licenses.purchase_id, licenses.product_id, products.product_name, purchases.purchase_date, EXTRACT(epoch FROM licenses.expiration) AS expiration FROM public.licenses INNER JOIN public.products ON (licenses.product_id = products.product_id) INNER JOIN public.purchases ON (licenses.purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 AND purchases.refunded = FALSE ORDER BY products.product_name;', $user->EmailId());
$has_purchased = $licenses->RecordCount() > 0;
$purchases = $database->Query('SELECT purchase_id, EXTRACT(epoch FROM purchase_date) AS purchase_date, total_paid, currency, refunded FROM purchases WHERE purchaser_email = $1 ORDER BY purchase_date DESC;', $user->EmailID());

if (!$has_purchased) {
	echo '<p class="text-center">You have not purchased Beacon Omni.<br><a href="/omni/">Learn more about Beacon Omni here.</a></p>';
	ShowGiftCodes();
	return;
}

$purchases = $database->Query('SELECT purchase_id, EXTRACT(epoch FROM purchase_date) AS purchase_date, total_paid, currency, refunded FROM purchases WHERE purchaser_email = $1 ORDER BY purchase_date DESC;', $user->EmailID());

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));

?><p>Thanks for purchasing Beacon Omni! Your support means a lot.</p>
<div id="section-activation" class="visual-group">
	<h3>Activating Beacon Omni</h3>
	<h3><a href="#with-internet" id="omni_show_instructions_internet">Option 1: Sign into your account in Beacon</a></h3>
	<div id="omni_instructions_internet" class="hidden"><?php include(BeaconCommon::WebRoot() . '/omni/welcome/instructions.php'); ?></div>
	<h3><a href="#without-internet" id="omni_show_instructions_no_internet">Option 2: Use an activation file for a computer without internet</a></h3>
	<div id="omni_instructions_no_internet" class="hidden">
		<div class="signin_step separator-color">
			<div id="img_signin_auth" class="img_signin separator-color">&nbsp;</div>
			<div class="signin_text">
				<h4>Create an Offline Authorization Request</h4>
				<p>Using the Help menu, choose &quot;Create Offline Authorization Request&quot; and save the file when prompted. You will need to transfer the to this computer. A USB memory stick is usually the easiest way to do it.</p>
			</div>
			<div class="push">&nbsp;</div>
		</div>
		<div class="signin_step separator-color" id="upload_container">
			<form id="upload_activation_form" method="post" action="/account/actions/activate" enctype="multipart/form-data">
				<input type="file" name="file" accept=".beaconauth" id="file_chooser"><input type="submit" value="Upload">
			</form>
			<div id="drop_area" class="separator-color"><span id="drop_initial_instructions">Drop your activation file here or <a href="" id="choose_file_button">choose the file</a>.</span><span id="drop_hover_instructions">Do it!</span></div>
		</div>
		<div class="signin_step separator-color">
			<div id="img_signin_import" class="img_signin separator-color">&nbsp;</div>
			<div id="img_signin_password" class="img_signin separator-color">&nbsp;</div>
			<div class="signin_text">
				<h4>Import your identity file</h4>
				<p>After uploading your activation file, you will have downloaded an identity file. Transfer the identity file back to the computer which created the authorization request.</p>
				<p>In Beacon, use the File menu, choose &quot;Import&quot; and select the identity file. When prompted, enter your account password.</p>
				<p>That's it, Beacon Omni will be ready for use.</p>
			</div>
			<div class="push">&nbsp;</div>
		</div>
	</div>
</div><?php

ShowLicenses();
ShowGiftCodes();
ShowPurchases();

function ShowGiftCodes() {
	global $user;
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT gift_codes.code, gift_codes.redemption_date, (SELECT ARRAY_TO_JSON(ARRAY_AGG(ROW_TO_JSON(products_template))) FROM (SELECT products.product_name, gift_code_products.quantity FROM public.gift_code_products INNER JOIN public.products ON (gift_code_products.product_id = products.product_id) WHERE gift_code_products.code = gift_codes.code) AS products_template) AS products FROM gift_codes INNER JOIN purchases ON (gift_codes.source_purchase_id = purchases.purchase_id) WHERE purchases.purchaser_email = $1 ORDER BY purchases.purchase_date DESC;', $user->EmailID());
	if ($results->RecordCount() == 0) {
		return;
	}
	
	echo '<div id="section-gifts" class="visual-group">';
	echo '<h3>Gift Codes</h3>';
	echo '<p>Codes can be redeemed at <a href="/redeem">' . BeaconCommon::AbsoluteURL('/redeem') . '</a> or using the link next to each code.</p>';
	echo '<table class="generic"><thead><tr><th class="w-40">Code</th><th class="low-priority w-60">Redemption Link</th></thead>';
	while (!$results->EOF()) {
		$code = $results->Field('code');
		$redeemed = is_null($results->Field('redemption_date')) === false;
		$products = json_decode($results->Field('products'), true);
		$products_list = [];
		foreach ($products as $product) {
			if ($product['quantity'] > 1) {
				$products_list[] = $product['quantity'] . ' x ' . $product['product_name'];
			} else {
				$products_list[] = $product['product_name'];
			}
		}
		
		echo '<tr><td class="w-40"><span class="text-lighter smaller">' . htmlentities(BeaconCommon::ArrayToEnglish($products_list)) . '</span><br>' . htmlentities($code) . '<div class="row-details"><span class="detail">' . ($redeemed ? 'Redeemed' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '<span></div></td><td class="low-priority w-40">' . ($redeemed ? 'Redeemed' : BeaconCommon::AbsoluteURL('/redeem/' . htmlentities($code))) . '</td></tr>';
		$results->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

function ShowLicenses() {
	global $user, $licenses;
	
	if (count($licenses) === 0) {
		return;
	}
	
	echo '<div id="section-licenses" class="visual-group">';
	echo '<h3>Licenses</h3>';
	echo '<table class="generic"><thead><tr><th class="w-50">Product</th><th class="low-priority w-30">Updates Until</th><th class="low-priority w-20">Actions</th></thead>';
	while ($licenses->EOF() === false) {
		$purchase_id = $licenses->Field('purchase_id');
		$product_id = $licenses->Field('product_id');
		$product_name = $licenses->Field('product_name');
		$expiration_seconds = $licenses->Field('expiration');
		$actions = [
			'View' => '/account/purchase/' . $purchaseId
		];
		
		if (is_null($expiration)) {
			$expirationText = 'Forever';
		} else {
			$expired = $expiration_seconds < time();
			$expiration_str = '<time class="no-localize' . ($expired ? ' text-red' : '') . '" datetime="' . date('Y-m-d H:i:s.000O', $expiration_seconds) . '">' . htmlentities(date('F jS Y', $expiration_seconds)) . '</time>';
			if ($expired) {
				$newest_build = BeaconCommon::NewestBuildForExpiration($expiration_seconds, true);
				$newest_version = BeaconCommon::BuildNumberToVersion($newest_build);
				$expiration_str .= '<br class="large-only"><span class="small-only">, </span>Version ' . $newest_version;
				
				$tokenSecret = BeaconCommon::GetGlobal('Legacy Download Secret');
				$tokenExpires = time() + 300;
				$token = BeaconCommon::Base64UrlEncode(hash('sha3-512', "{$newest_build}:{$tokenExpires}:{$tokenSecret}", true));
				
				$actions['Download'] = "/download/{$newest_build}?token={$token}&expires={$tokenExpires}";
			}
		}
		
		$actionHtmlMembers = [];
		foreach ($actions as $text => $url) {
			$actionHtmlMembers[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actionsHtml = implode(' ', $actionHtmlMembers);
		
		echo '<tr><td class="w-50">' . htmlentities($product_name) . '<div class="row-details"><span class="detail">Receives updates until ' . $expiration_str . '</span><span class="detail">Actions: ' . $actions_html . '</div></td><td class="low-priority w-30 smaller">' . $expiration_str . '</td><td class="low-priority w-20 text-center">' . $actions_html . '</td></tr>';
		
		$licenses->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

function ShowPurchases() {
	global $user, $purchases;
	
	if ($purchases->RecordCount() === 0) {
		return;
	}
	
	BeaconTemplate::LoadGlobalize();
	
	echo '<div id="section-licenses" class="visual-group">';
	echo '<h3>All Purchases</h3>';
	echo '<table class="generic"><thead><tr><th class="w-60">Purchase Date</th><th class="w-20">Total</th><th class="low-priority w-20">Actions</th></thead>';
	while ($purchases->EOF() === false) {
		$purchase_id = $purchases->Field('purchase_id');
		$actions = ['View' => '/account/purchase/' . $purchase_id];
		$purchase_time = intval($purchases->Field('purchase_date'));
		$purchase_time_str = '<time datetime="' . date('Y-m-d H:i:s.000O', $purchase_time) . '">' . htmlentities(date('F jS Y g:i:s A e', $purchase_time)) . '</time>';
		$refunded = $purchases->Field('refunded');
		
		$actions_html_members = [];
		foreach ($actions as $text => $url) {
			$actions_html_members[] = '<a class="action-link" href="' . htmlentities($url) . '">' . htmlentities($text) . '</a>';
		}
		$actions_html = implode(' ', $actions_html_members);
		
		$total = $purchases->Field('total_paid');
		$currency = $purchases->Field('currency');
			
		if ($refunded) {
			$purchase_time_str = '<span class="redacted text-red">' . $purchase_time_str . '</span> Refunded';
		}
		
		echo '<tr><td class="w-60">' . $purchase_time_str . '<div class="row-details"><span class="detail">Actions: ' . $actions_html . '</span></div></td><td class="w-20 text-right nowrap formatted-price" beacon-currency="' . htmlentities($currency) . '">' . htmlentities($total) . '</td><td class="low-priority w-20 text-center">' . $actions_html . '</td>';
		
		$purchases->MoveNext();
	}
	echo '</table>';
	echo '</div>';
}

?>
