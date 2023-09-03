<?php

if ($user->IsChildAccount()) {
	echo '<p class="text-center">Your account is controlled by another user. Your account cannot have team members.</p>';
	return;
}

BeaconTemplate::AddStylesheet('/account/assets/team.css');
BeaconTemplate::AddScript('/account/assets/team.js');

echo '<div class="child_seat_status">';
$purchased_seat_count = $user->TotalChildSeats();
$used_seat_count = $user->UsedChildSeats();
$remaining_seats = $purchased_seat_count - $used_seat_count;
echo '<p class="slot_explanation">';
if ($purchased_seat_count == 0) {
	echo 'You have not purchased any team member licenses.';
} else {
	echo 'You have used <span class="slot_count used_slot_count">' . $user->UsedChildSeats() . '</span> of your <span class="slot_count total_slot_count">' . number_format($purchased_seat_count, 0) . '</span> team member license' . ($purchased_seat_count != 1 ? 's' : '') . '.';
}
echo '</p><p><button id="buy_slots_button" class="default">Buy More Licenses</button>';
if ($remaining_seats > 0) {
	echo '<button id="add-account-button">Add Team Member</button>';
}
echo '</p><p><a href="/omni/team">Learn more about Beacon for teams</a></div>';

$children = $user->ChildAccounts();
if (count($children) > 0) {
	echo '<table class="generic">';
	echo '<thead><tr><th>Name</th><th class="low-priority">Enabled</th><th class="low-priority">Actions</th></tr></thead>';
	foreach ($children as $child) {
		$action_links = [];
		if ($child->IsEnabled() === false && $remaining_seats > 0) {
			$action_links[] = '<a href="team/enable" class="enable-button" beacon-user-id="' . $child->UserID() . '" beacon-user-name="' . htmlentities($child->Username()) . '">Enable</a>';
			$action_links[] = '<a href="team/delete" class="delete-button" beacon-user-id="' . $child->UserID() . '" beacon-user-name="' . htmlentities($child->Username()) . '">Delete</a>';
		} else if ($child->IsEnabled()) {
			$action_links[] = '<a href="team/disable" class="disable-button" beacon-user-id="' . $child->UserID() . '" beacon-user-name="' . htmlentities($child->Username()) . '">Disable</a>';
		}
		
		echo '<tr>';
		echo '<td>' . htmlentities($child->Username()) . '<span class="user-suffix">#' . htmlentities($child->Suffix()) . '</span><div class="row-details"><span class="detail">' . ($child->IsEnabled() ? 'Enabled' : 'Disabled') . '</span><span class="detail">' . implode('</span><span class="detail">', $action_links) . '</span></div></td>';
		echo '<td class="low-priority text-center nowrap">' . ($child->IsEnabled() ? 'Yes' : 'No') . '</td>';
		echo '<td class="low-priority text-center nowrap">' . implode('<br>', $action_links) . '</td>';
	}
	echo '</table>';
	echo '<p class="smaller text-center text-lighter">Disabled accounts do not count against your license usage.<br><a href="team/reset" id="reset-member-button">Reset Member Password</a></p>';
}

BeaconTemplate::StartModal('add-team-modal');
?><p class="title-bar">Add Team Member</p>
<p>Enter the email address of the new member, as well as a default username. The user will be able to change their username later. An email will be sent containing a link which must be followed to begin using the account.</p>
<p class="notice-block notice-warning hidden" id="add-error-space">That didn't work</p>
<p class="field-pair"><label for="add-email-field">Member Email Address</label><input type="email" id="add-email-field" placeholder="Member Email Address"></p>
<p class="field-pair"><label for="add-username-field">Member Username</label><input type="text" id="add-username-field" placeholder="Member Username"></p>
<p class="field-pair"><label for="add-password-field">Your Account Password</label><input type="password" id="add-password-field" placeholder="Your Account Password"></p>
<div class="button-bar"><div class="left"><div class="spinner hidden" id="add-spinner"></div></div><div class="right"><button id="add-cancel-button">Cancel</button><button id="add-action-button" class="default" disabled>Add Member</button></div></div><?php
BeaconTemplate::FinishModal();

BeaconTemplate::StartModal('reset-password-modal');
?><p class="title-bar">Reset Member Password</p>
<p>If a team member forgets their password, only you can reset their password. Because Beacon does not store email addresses, you will need to provide the email address to the user's account so they can be sent a reset link email.</p>
<p class="notice-block notice-warning hidden" id="reset-error-space">That didn't work</p>
<p class="field-pair"><label for="reset-email-field">Member Email Address</label><input type="email" id="reset-email-field" placeholder="Member Email Address"></p>
<p class="field-pair"><label for="reset-password-field">Your Account Password</label><input type="password" id="reset-password-field" placeholder="Your Account Password"></p>
<div class="button-bar"><div class="left"><div class="spinner hidden" id="reset-spinner"></div></div><div class="right"><button id="reset-cancel-button">Cancel</button><button id="reset-action-button" class="default" disabled>Reset Password</button></div></div><?php
BeaconTemplate::FinishModal();

?>
