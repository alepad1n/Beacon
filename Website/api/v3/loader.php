<?php
	
header('Content-Type: application/json');
header('Cache-Control: no-cache');

// classes local to this API will get loaded first
spl_autoload_register(function($class_name) {
	$parts = explode('\\', $class_name, 2);
	$potentials = [];
	if (count($parts) === 1) {
		$potentials[] = dirname(__FILE__) . '/classes/' . $class_name . '.php';
	} elseif (count($parts) === 2) {
		if ($parts[0] === 'BeaconAPI') {
			$potentials[] = dirname(__FILE__, 2) . '/common/' . str_replace('\\', '/', $parts[1]) . '.php';
		} else {
			$potentials[] = dirname(__FILE__) . '/' . strtolower($parts[0]) . '/classes/' . str_replace('\\', '/', $parts[1]) . '.php';
			$potentials[] = dirname(__FILE__) . '/classes/' . $parts[0] . '/' . str_replace('\\', '/', $parts[1]) . '.php';
		}
	}
	foreach ($potentials as $file) {
		if (file_exists($file)) {
			include($file);
			return;
		}
	}
});

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconAPI::HandleCORS();

?>