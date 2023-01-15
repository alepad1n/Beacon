<?php

namespace BeaconAPI;

abstract class Core {
	protected static $user_id = null;
	protected static $payload = null;
	protected static $body_raw = null;
	protected static $auth_style = null;
	protected static $routes = [];
	
	const AUTH_STYLE_PUBLIC_KEY = 'public key';
	const AUTH_STYLE_EMAIL_WITH_PASSWORD = 'email+password';
	const AUTH_STYLE_SESSION = 'session';
	
	const AUTH_OPTIONAL = 1;
	const AUTH_PERMISSIVE = 2;
	
	public static function HandleCORS(): void {
		header('Access-Control-Allow-Origin: *');
		header('Access-Control-Allow-Methods: GET, POST, DELETE, PUT, OPTIONS');
		header('Access-Control-Allow-Headers: DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range,X-Beacon-Upgrade-Encryption,X-Beacon-Token,Authorization');
		header('Access-Control-Expose-Headers: Content-Length,Content-Range');
		header('Vary: Origin');
		
		if (static::Method() === 'OPTIONS') {
			header('Access-Control-Max-Age: 1728000');
			http_response_code(204);
			exit;
		}
	}
	
	public static function APIVersion() {
		return 'v0';
	}
	
	public static function UsesLegacyEncryption() {
		return true;
	}
	
	public static function Body() {
		if (self::$body_raw === null) {
			if (self::Method() == 'GET') {
				self::$body_raw = $_SERVER['QUERY_STRING'];
			} else {
				self::$body_raw = file_get_contents('php://input');
			}
			if (isset($_SERVER['HTTP_CONTENT_ENCODING']) && $_SERVER['HTTP_CONTENT_ENCODING'] == 'gzip') {
				self::$body_raw = gzdecode(self::$body_raw);
			}
		}
		return self::$body_raw;
	}
	
	public static function JSONPayload() {
		if (self::$payload === null) {
			self::$payload = json_decode(self::Body(), true);
		}
		return self::$payload;
	}
	
	public static function ReplySuccess($payload = null, int $code = 200) {
		header('Content-Type: application/json');
		http_response_code($code);
		if ($payload !== null) {
			$response = json_encode($payload, JSON_PRETTY_PRINT);
			if ($response === false) {
				static::ReplyError('Unable to encode JSON response', json_last_error_msg(), 500);
			} else {
				echo $response;
			}
		}
		exit;
	}
	
	public static function ReplyError(string $message, $payload = null, $code = 400) {
		header('Content-Type: application/json');
		http_response_code($code);
		echo json_encode(array('message' => $message, 'details' => $payload), JSON_PRETTY_PRINT);
		exit;
	}
	
	public static function RequireKeys(string ...$keys) {
		$request = self::JSONPayload();
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($request[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			self::ReplyError('Missing required keys.', $missing);
		}
	}
	
	public static function RequireParams(string ...$keys) {
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($_GET[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			self::ReplyError('Missing required parameters.', $missing);
		}
	}
	
	public static function Method() {
		return strtoupper($_SERVER['REQUEST_METHOD']);
	}
	
	public static function ContentType() {
		$pos = strpos($_SERVER['CONTENT_TYPE'], ';');
		if ($pos === false) {
			return strtolower($_SERVER['CONTENT_TYPE']);
		} else {
			return substr(strtolower($_SERVER['CONTENT_TYPE']), 0, $pos);
		}
	}
	
	protected static function AuthorizeWithSessionID(string $session_id) {
		$session = \BeaconSession::GetBySessionID($session_id);
		if (is_null($session) == false) {
			$user = $session->User();
			if (is_null($user) || $user->CanSignIn() === false) {
				return false;
			}
			
			self::$user_id = $session->UserID();
			self::$auth_style = self::AUTH_STYLE_SESSION;
			
			$session->Renew();
			
			return true;
		}
		return false;
	}
	
	protected static function AuthorizeWithPassword(string $username, string $password) {
		$user = \BeaconUser::GetByEmail($username);
		if (is_null($user) == false && $user->TestPassword($password)) {
			if ($user->CanSignIn() === false) {
				if ($user->RequiresPasswordChange() === true) {
					\BeaconLogin::SendForcedPasswordChangeEmail($username, $password);
				}
				return false;
			}
			self::$user_id = $user->UserID();
			self::$auth_style = self::AUTH_STYLE_EMAIL_WITH_PASSWORD;
			return true;
		}
		return false;
	}
	
	protected static function AuthorizeWithSignature(\BeaconUser $user, string $challenge, string $signature) {
		if (is_null($user) || $user->CanSignIn() === false) {
			return false;
		}
		
		if (\BeaconCommon::IsHex($signature)) {
			$signature = hex2bin($signature);
		}
		
		if ($user->CheckSignature($challenge, $signature)) {
			self::$user_id = $user->UserID();
			self::$auth_style = self::AUTH_STYLE_PUBLIC_KEY;
			return true;
		}
		
		return false;
	}
	
	public static function Authorize(bool|int $flags = 0) {
		if ($flags === true) {
			$flags = self::AUTH_OPTIONAL;
		} else if ($flags === false) {
			$flags = 0;
		}	
		
		$optional = ($flags & self::AUTH_OPTIONAL) === self::AUTH_OPTIONAL;
		$permissive = ($flags & self::AUTH_PERMISSIVE) === self::AUTH_PERMISSIVE;
		
		$authorized = false;
		$content = '';
		self::$user_id = \BeaconCommon::GenerateUUID(); // To return a "new" UUID even if authorization fails.
		$http_fail_status = 401;
		
		if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
			$http_fail_status = 403;
			$optional = false; // if authorization included, it is no longer optional
			$authorization = $_SERVER['HTTP_AUTHORIZATION'];
			$pos = strpos($authorization, ' ');
			$auth_type = strtolower(substr($authorization, 0, $pos));
			$auth_value = substr($authorization, $pos + 1);
			
			switch ($auth_type) {
			case 'session':
				$authorized = self::AuthorizeWithSessionID($auth_value);
				break;
			case 'basic':
				if ($permissive) {
					$decoded = base64_decode($auth_value);
					list($username, $password) = explode(':', $decoded, 2);
					
					if (\BeaconCommon::IsUUID($username)) {
						// public key authorization
						$user = \BeaconUser::GetByUserID($username);
						
						// with 2FA enabled, only session tokens and challenges are accepted
						if (is_null($user) === false && $user->Is2FAProtected() === false) {
							$url = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
							$content = self::Method() . chr(10) . $url;
							if (self::Method() !== 'GET') {
								$content .= chr(10) . self::Body();
							}
							
							$authorized = self::AuthorizeWithSignature($user, $content, $password);
						}
					} elseif (\BeaconUser::ValidateEmail($username)) {
						// password authorization
						$authorized = self::AuthorizeWithPassword($username, $password);
					}
				}
				break;
			case 'challenge':
				if ($permissive) {
					$decoded = base64_decode($auth_value);
					list($user_id, $signature) = explode(':', $decoded, 2);
					
					if (\BeaconCommon::IsUUID($user_id)) {
						$user = \BeaconUser::GetByUserID($user_id);
						$database = \BeaconCommon::Database();
						$results = $database->Query('SELECT challenge FROM user_challenges WHERE user_id = $1;', $user_id);
						while (!$results->EOF()) {
							$challenge = $results->Field('challenge');
							if (static::AuthorizeWithSignature($user, $challenge, $signature)) {
								$authorized = true;
								break;
							}
							$results->MoveNext();
						}
					}
				}
				break;
			}
		} elseif (self::Method() === 'POST' && self::ContentType() === 'application/json') {
			if ($permissive) {
				$payload = self::JSONPayload();
				if ($payload !== false && (empty($payload['username']) === false && empty($payload['password']) === false)) {
					$authorized = self::AuthorizeWithPassword($payload['username'], $payload['password']);
				} elseif ($payload !== false && (empty($payload['user_id']) === false && empty($payload['signature']) === false)) {
					$database = \BeaconCommon::Database();
					$results = $database->Query('SELECT challenge FROM user_challenges WHERE user_id = $1;', $payload['user_id']);
					if ($results->RecordCount() == 1) {
						$challenge = $results->Field('challenge');
						$user = \BeaconUser::GetByUserID($payload['user_id']);
						if (is_null($user) === false) {
							$authorized = self::AuthorizeWithSignature($user, $challenge, $payload['signature']);
						}
					}
				}
			}
		} elseif (empty($_SERVER['HTTP_X_BEACON_TOKEN']) === false) {
			$authorized = self::AuthorizeWithSessionID($_SERVER['HTTP_X_BEACON_TOKEN']);
		}
		
		if ($authorized) {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM user_challenges WHERE user_id = $1;', self::$user_id);
			$database->Commit();
		}
		
		if ((!$authorized) && (!$optional)) {
			header('WWW-Authenticate: Basic realm="Beacon API"');
			self::ReplyError('Unauthorized', $content, $http_fail_status);
		}
	}
	
	public static function Authenticated() {
		return is_null(self::$auth_style) == false;
	}
	
	public static function AuthenticationMethod() {
		return self::$auth_style;
	}
	
	public static function UserID() {
		return self::$user_id;
	}
	
	public static function User() {
		return \BeaconUser::GetByUserID(self::$user_id);
	}
	
	public static function ObjectID(int $place = 0) {
		if (!isset($_SERVER['PATH_INFO'])) {
			return null;
		}
		
		$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
		if ((is_array($request) === false) || (count($request) == 0)) {
			return null;
		}
		
		if (empty($request[$place])) {
			return null;
		}
		
		return $request[$place];
	}
	
	public static function ObjectCount() {
		$object_id = self::ObjectID();
		$arr = explode(',', $object_id);
		return count($arr);
	}
	
	public static function URL(string $path = '/') {
		if (strlen($path) == 0 || substr($path, 0, 1) != '/') {
			$path = '/' . $path;
		}
		$domain = \BeaconCommon::APIDomain();
		return 'https://' . $domain . '/' . static::APIVersion() . $path;
	}
	
	public static function RegisterRoutes(array $routes): void {
		foreach ($routes as $route => $handlers) {
			preg_match_all('/\{((\.\.\.)?[a-zA-Z0-9\-_]+?)\}/', $route, $placeholders);
			
			$route_expression = str_replace('/', '\\/', $route);
			$match_count = count($placeholders[0]);
			$variables = [];
			for ($idx = 0; $idx < $match_count; $idx++) {
				$original = $placeholders[0][$idx];
				$key = $placeholders[1][$idx];
				if (str_starts_with($key, '...')) {
					$exclude = '\?';
					$key = substr($key, 3);
				} else {
					$exclude = '\/\?';
				}
				$variables[] = $key;
				$pattern = '(?P<' . $key . '>[^' . $exclude . ']+?)';
				$route_expression = str_replace($original, $pattern, $route_expression);
			}
			$route_expression = '/^' . $route_expression . '$/';
			
			self::$routes[$route] = [
				'expression' => $route_expression,
				'handlers' => $handlers,
				'variables' => $variables
			];
		}
	}
	
	public static function HandleRequest(string $root): void {
		$request_route = '/' . $_GET['route'];
		foreach (self::$routes as $route => $route_info) {
			$route_expression = $route_info['expression'];
			$handlers = $route_info['handlers'];
			$variables = $route_info['variables'];
			
			if (preg_match($route_expression, $request_route, $matches) !== 1) {
				continue;
			}
			
			$request_method = strtoupper($_SERVER['REQUEST_METHOD']);
			if ($request_method === 'PUT') {
				$request_method = 'POST';
			}
			if (isset($handlers[$request_method]) === false) {
				static::ReplyError('Method not allowed', null, 405);
			}
			
			$handler = $handlers[$request_method];
			if (is_string($handler)) {
				$handler_file = $root . '/' . $handler . '.php';
				if (file_exists($handler_file) === false) {
					static::ReplyError('Endpoint not found', null, 404);
				}
				$handler = 'handle_request';
				try {
					http_response_code(500); // Set a default. If there is a fatal error, it'll still be set.
					require($handler_file);
				} catch (\Throwable $err) {
					static::ReplyError('Error loading api source file.', null, 500);
				}
			} else if (is_callable($handler) === true) {
				// nothing to do
			} else {
				static::ReplyError('Endpoint not found', null, 404);
			}
			
			$route_key = $request_method . ' ' . $route;
			$path_parameters = [];
			foreach ($variables as $variable_name) {
				$path_parameters[$variable_name] = $matches[$variable_name];
			}
			
			$context = [
				'path_parameters' => $path_parameters,
				'route_key' => $route_key
			];
			$handler($context);
			return;
		}
		static::ReplyError('Endpoint not found: Route not registered.', null, 404);
	}
}

?>
