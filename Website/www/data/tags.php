<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Ark\Blueprint;

if (empty($_GET['tag'])) {
	http_response_code(400);
	echo 'Missing tag parameter';
	exit;
}

$tag = $_GET['tag'];
$tag_human = ucwords(str_replace('_', ' ', $tag));
$objects = Blueprint::Search(['tag' =>$tag, 'minVersion' => BeaconCommon::MinVersion()], true);
if (count($objects) == 0) {
	echo '<h1>No Objects Tagged &quot;' . htmlentities($tag_human) . '&quot;</h1>';
	echo '<p>Sorry</p>';
	exit;
}

echo '<h1>Objects Tagged &quot;' . htmlentities($tag_human) . '&quot;</h1>';
echo '<ul class="object_list">';
foreach ($objects as $object) {
	echo '<li><a href="/object/' . urlencode($object->UUID()) . '">' . htmlentities($object->Label()) . '</a></li>';
}
echo '</ul>';

?>
