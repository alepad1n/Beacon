<?php

namespace BeaconAPI\v4;
use BeaconAPI\v4\{DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCloudStorage, BeaconCommon, BeaconRecordSet, DateTime, Exception;

abstract class Project extends DatabaseObject implements \JsonSerializable {
	const PUBLISH_STATUS_PRIVATE = 'Private';
	const PUBLISH_STATUS_REQUESTED = 'Requested';
	const PUBLISH_STATUS_APPROVED = 'Approved';
	const PUBLISH_STATUS_APPROVED_PRIVATE = 'Approved But Private';
	const PUBLISH_STATUS_DENIED = 'Denied';
	
	protected $project_id = '';
	protected $game_id = '';
	protected $game_specific = [];
	protected $user_id = '';
	protected $owner_id = '';
	protected $title = '';
	protected $description = '';
	protected $console_safe = true;
	protected $last_update = null;
	protected $revision = 1;
	protected $download_count = 0;
	protected $published = self::PUBLISH_STATUS_PRIVATE;
	protected $content = [];
	protected $storage_path = null;
	
	protected function __construct(BeaconRecordSet $row) {
		$this->project_id = $row->Field('project_id');
		$this->game_id = $row->Field('game_id');
		$this->title = $row->Field('title');
		$this->description = $row->Field('description');
		$this->revision = intval($row->Field('revision'));
		$this->download_count = intval($row->Field('download_count'));
		$this->last_update = new DateTime($row->Field('last_update'));
		$this->user_id = $row->Field('user_id');
		$this->owner_id = $row->Field('owner_id');
		$this->published = $row->Field('published');
		$this->console_safe = boolval($row->Field('console_safe'));
		$this->game_specific = json_decode($row->Field('game_specific'), true);
		$this->storage_path = $row->Field('storage_path');
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'allowed_projects', [
			new DatabaseObjectProperty('project_id', ['primaryKey' => true]),
			new DatabaseObjectProperty('game_id'),
			new DatabaseObjectProperty('game_specific'),
			new DatabaseObjectProperty('user_id'),
			new DatabaseObjectProperty('owner_id'),
			new DatabaseObjectProperty('title'),
			new DatabaseObjectProperty('description'),
			new DatabaseObjectProperty('console_safe'),
			new DatabaseObjectProperty('last_update'),
			new DatabaseObjectProperty('revision'),
			new DatabaseObjectProperty('download_count'),
			new DatabaseObjectProperty('published'),
			new DatabaseObjectProperty('storage_path')
		]);
	}
	
	protected static function NewInstance(BeaconRecordSet $rows): Project {
		$game_id = $rows->Field('game_id');
		switch ($game_id) {
		case 'Ark':
			return new Ark\Project($rows);
			break;
		default:
			throw new Exception('Unknown game ' . $game_id);
		}
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		$parameters->orderBy = 'last_update DESC';
		
		// We want to list only "original" projects, not shared projects.
		$parameters->clauses[] = 'user_id = owner_id';
		
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'user_id');
		$parameters->AddFromFilter($schema, $filters, 'published');
		$parameters->AddFromFilter($schema, $filters, 'console_safe');
	}
	
	public static function SchemaName() {
		return 'public';
	}
		
	public static function TableName() {
		return 'projects';
	}
	
	public static function AllowedTableName() {
		return 'allowed_projects';
	}
	
	public static function GuestTableName() {
		return 'guest_projects';
	}
	
	public static function SQLColumns() {
		return [
			'project_id',
			'game_id',
			'user_id',
			'owner_id',
			'title',
			'description',
			'console_safe',
			'last_update',
			'revision',
			'download_count',
			'published',
			'game_specific',
			'storage_path'
		];
	}
	
	public function jsonSerialize(): mixed {
		return [
			'project_id' => $this->project_id,
			'game_id' => $this->game_id,
			'user_id' => $this->user_id,
			'owner_id' => $this->owner_id,
			'name' => $this->title,
			'description' => $this->description,
			'revision' => $this->revision,
			'download_count' => $this->download_count,
			'last_updated' => $this->last_update->format('Y-m-d H:i:sO'),
			'console_safe' => $this->console_safe,
			'published' => $this->published,
			'resource_url' => $this->ResourceURL()
		];
	}
		
	public function ProjectID() {
		return $this->project_id;
	}
	
	public function DocumentID() {
		// Legacy compatibility alias
		return $this->project_id;
	}
	
	public function GameID() {
		return $this->game_id;
	}
	
	public function GameURLComponent() {
		switch ($this->game_id) {
		case 'Ark':
			return 'ark';
		}
	}
	
	public function UserID() {
		return $this->user_id;
	}
	
	public function OwnerID() {
		return $this->owner_id;
	}
	
	public function Title() {
		return $this->title;
	}
	
	public function Name() {
		// Legacy compatibility alias
		return $this->title;
	}
	
	public function Description() {
		return $this->description;
	}
	
	public function ConsoleSafe() {
		return $this->console_safe;
	}
	
	public function LastUpdated() {
		return $this->last_update;
	}
	
	public function Revision() {
		return $this->revision;
	}
	
	public function DownloadCount() {
		return $this->download_count;
	}
	
	public function IsPublic() {
		return $this->published == PUBLISH_STATUS_APPROVED;
	}
	
	public function PublishStatus() {
		return $this->published;
	}
	
	public function SetPublishStatus(string $desired_status) {
		$database = BeaconCommon::Database();
		
		$results = $database->Query('SELECT published FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE project_id = $1;', $this->project_id);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($desired_status == self::PUBLISH_STATUS_REQUESTED || $desired_status == self::PUBLISH_STATUS_APPROVED) {
			if ($current_status == self::PUBLISH_STATUS_APPROVED_PRIVATE) {
				$new_status = self::PUBLISH_STATUS_APPROVED;
			} elseif ($current_status == self::PUBLISH_STATUS_PRIVATE) {
				if (empty(trim($this->description))) {
					$new_status = self::PUBLISH_STATUS_DENIED;
				} else {
					$new_status = self::PUBLISH_STATUS_REQUESTED;
					$attachment = array(
						'title' => $this->title,
						'text' => $this->description,
						'fallback' => 'Unable to show response buttons.',
						'callback_id' => 'publish_document:' . $this->project_id,
						'actions' => array(
							array(
								'name' => 'status',
								'text' => 'Approve',
								'type' => 'button',
								'value' => self::PUBLISH_STATUS_APPROVED,
								'confirm' => array(
									'text' => 'Are you sure you want to approve this project?',
									'ok_text' => 'Approve'
								)
							),
							array(
								'name' => 'status',
								'text' => 'Deny',
								'type' => 'button',
								'value' => self::PUBLISH_STATUS_DENIED,
								'confirm' => array(
									'text' => 'Are you sure you want to reject this project?',
									'ok_text' => 'Deny'
								)
							)
						),
						'fields' => array()
					);
					
					$user = User::GetByUserID($this->user_id);
					if (is_null($user) === false) {
						if ($user->IsAnonymous()) {
							$username = 'Anonymous';
						} else {
							$username = $user->Username() . '#' . $user->Suffix();
						}
						$attachment['fields'][] = array(
							'title' => 'Author',
							'value' => $username
						);
					}
					
					$obj = array(
						'text' => 'Request to publish project',
						'attachments' => array($attachment)
					);
					BeaconCommon::PostSlackRaw(json_encode($obj));
				}
			}
		} else {
			if ($current_status == self::PUBLISH_STATUS_APPROVED) {
				$new_status = self::PUBLISH_STATUS_APPROVED_PRIVATE;
			} elseif ($current_status == self::PUBLISH_STATUS_REQUESTED) {
				$new_status = self::PUBLISH_STATUS_PRIVATE;
			}
		}
		if ($new_status != $current_status) {
			$database->BeginTransaction();
			$database->Query('UPDATE ' . static::SchemaName() . '.' . static::TableName() . ' SET published = $2 WHERE project_id = $1;', $this->project_id, $new_status);
			$database->Commit();
		}
		$this->published = $new_status;
	}
	
	public function PreloadContent($version_id = null) {
		$content_key = (is_null($version_id) === true ? '' : $version_id);
		if (array_key_exists($content_key, $this->content) === true) {
			return $content_key;
		}
		
		$this->content[$content_key] = BeaconCloudStorage::GetFile($this->CloudStoragePath(), true, $version_id);
		return $content_key;
	}	
	
	public function Content(bool $compressed = false, bool $parsed = true, $version_id = null) {
		try {
			$content_key = $this->PreloadContent($version_id);
		} catch (Exception $err) {
			return '';
		}
		
		$content = $this->content[$content_key];
		$compressed = $compressed && ($parsed == false);
		$is_compressed = BeaconCommon::IsCompressed($content);
		if ($is_compressed == true && $compressed == false) {
			$content = gzdecode($content);
		} elseif ($is_compressed == false && $compressed == true) {
			return gzencode($content);
		}
		if ($parsed) {
			return json_decode($content, true);
		} else {
			return $content;
		}
	}
	
	public function ResourceURL() {
		return Core::URL('projects/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
	
	public static function GetAll() {
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('user_id = owner_id'));
		return self::GetFromResults($results);
	}
	
	public static function GetByDocumentID(string $project_id) {
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('project_id = ANY($1) AND user_id = owner_id'), '{' . $project_id . '}');
		return self::GetFromResults($results);
	}
	
	public static function GetDocumentByID(string $project_id) {
		// Just an alias for GetByDocumentID to make sense with GetSharedDocumentByID
		return self::GetByDocumentID($project_id);
	}
	
	public static function GetSharedDocumentByID(string $project_id, $user_id) {
		if (is_null($user_id)) {
			return self::GetByDocumentID($project_id);
		}
		
		$database = BeaconCommon::Database();
		$results = $database->Query(static::BuildSQL('project_id = ANY($1) AND user_id = $2'), '{' . $project_id . '}', $user_id);
		$projects = self::GetFromResults($results);
		if (count($projects) === 0) {
			$projects = self::GetByDocumentID($project_id);
		}
		return $projects;
	}
	
	protected static function HookHandleSearchKey(string $column, $value, array &$clauses, array &$values, int &$next_placeholder) {
		
	}
	
	/*public static function Search(array $params, string $order_by = 'last_update DESC', int $count = 0, int $offset = 0, bool $count_only = false) {
		$next_placeholder = 1;
		$values = array();
		$clauses = array();
		
		foreach ($params as $column => $value) {
			switch ($column) {
			case 'project_id':
			case 'document_id':
			case 'id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'project_id = ANY($' . $next_placeholder++ . ')';
				} elseif (BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'project_id = $' . $next_placeholder++;
				}
				break;
			case 'public':
			case 'is_public':
				$clauses[] = 'published = \'Approved\'';
				break;
			case 'published':
				$values[] = $value;
				$clauses[] = 'published = $' . $next_placeholder++;
				break;
			case 'user_id':
				if (is_array($value)) {
					$values[] = '{' . implode(',', $value) . '}';
					$clauses[] = 'user_id = ANY($' . $next_placeholder++ . ')';
				} elseif (is_null($value)) {
					$clauses[] = 'user_id IS NULL';
				} elseif (BeaconCommon::IsUUID($value)) {
					$values[] = $value;
					$clauses[] = 'user_id = $' . $next_placeholder++;
				}
				break;
			case 'console_safe':
				$values[] = boolval($value);
				$clauses[] = 'console_safe = $' . $next_placeholder++;
				break;
			default:
				static::HookHandleSearchKey($column, $value, $clauses, $values, $next_placeholder);
				break;
			}
		}
		
		// We want to list only "original" projects, not shared projects.
		$clauses[] = 'user_id = owner_id';
		
		$database = BeaconCommon::Database();
		if ($count_only) {
			$sql = 'SELECT COUNT(project_id) AS project_count FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE ' . implode(' AND ', $clauses) . ';';
			$results = $database->Query($sql, $values);
			return $results->Field('project_count');
		} else {
			$sql = static::BuildSQL(implode(' AND ', $clauses), $order_by, $count, $offset);
			$results = $database->Query($sql, $values);
			return self::GetFromResults($results);
		}
	}*/
	
	public static function GetFromResults(BeaconRecordSet $results) {
		if ($results === null || $results->RecordCount() === 0) {
			return array();
		}
		
		$projects = array();
		while (!$results->EOF()) {
			$project = static::GetFromResult($results);
			if ($project !== null) {
				$projects[] = $project;
			}
			$results->MoveNext();
		}
		return $projects;
	}
	
	// Deprecated
	protected static function GetFromResult(BeaconRecordSet $results) {
		return static::NewInstance($results);
	}
	
	protected static function BuildSQL(string $clause = '', string $order_by = 'last_update DESC', int $count = 0, int $offset = 0) {
		$sql = 'SELECT ' . implode(', ', static::SQLColumns()) . ' FROM ' . static::SchemaName() . '.' . static::AllowedTableName();
		if ($clause !== '') {
			$sql .= ' WHERE ' . $clause;
		}
		if ($order_by !== '') {
			$sql .= ' ORDER BY ' . $order_by;
		}
		if ($count > 0) {
			$sql .= ' LIMIT ' . $count;
		}
		if ($offset > 0) {
			$sql .= ' OFFSET ' . $offset;
		}
		$sql .= ';';
		return $sql;
	}
	
	public function CloudStoragePath() {
		if (is_null($this->storage_path)) {
			$this->storage_path = static::GenerateCloudStoragePath($this->project_id);
		}
		return $this->storage_path;
	}
	
	protected static function GenerateCloudStoragePath(string $project_id) {
		return '/Projects/' . strtolower($project_id) . '.beacon';
	}
	
	protected static function HookValidateMultipart(array &$required_vars, string &$reason) {
		return true;
	}
	
	protected static function HookMultipartAddProjectValues(array &$project, string &$reason) {
		return true;
	}
	
	public static function SaveFromMultipart(User $user, string &$reason) {
		$required_vars = ['keys', 'title', 'uuid', 'version'];
		if (static::HookValidateMultipart($required_vars, $reason) === false) {
			return false;
		}
		$missing_vars = [];
		foreach ($required_vars as $var) {
			if (isset($_POST[$var]) === false || empty($_POST[$var]) === true) {
				$missing_vars[] = $var;
			}
		}
		if (isset($_POST['description']) === false) {
			// description is allowed to be empty
			$missing_vars[] = 'description';
		}
		if (isset($_FILES['contents']) === false) {
			$missing_vars[] = 'contents';
			sort($missing_vars);
		}
		if (count($missing_vars) > 0) {
			$reason = 'The following parameters are missing: `' . implode('`, `', $missing_vars) . '`';
			return false;
		}
		
		$upload_status = $_FILES['contents']['error'];
		switch ($upload_status) {
		case UPLOAD_ERR_OK:
			break;
		case UPLOAD_ERR_NO_FILE:
			$reason = 'No file included.';
			break;
		case UPLOAD_ERR_INI_SIZE:
		case UPLOAD_ERR_FORM_SIZE:
			$reason = 'Exceeds maximum file size.';
			break;
		default:
			$reason = 'Other error ' . $upload_status . '.';
			break;
		}
		
		if (BeaconCommon::IsCompressed($_FILES['contents']['tmp_name'], true) === false) {
			$source = $_FILES['contents']['tmp_name'];
			$destination = $source . '.gz';
			if ($read_handle = fopen($source, 'rb')) {
				if ($write_handle = gzopen($destination, 'wb9')) {
					while (!feof($read_handle)) {
						gzwrite($write_handle, fread($read_handle, 524288));
					}
					gzclose($write_handle);
				} else {
					fclose($read_handle);
					$reason = 'Could not create compressed file.';
					return false;
				}
				fclose($read_handle);
			} else {
				$reason = 'Could not read uncompressed file.';
				return false;
			}
			unlink($source);
			rename($destination, $source);
		}
		
		$project = [
			'Version' => intval($_POST['version']),
			'Identifier' => $_POST['uuid'],
			'Title' => $_POST['title'],
			'Description' => $_POST['description']
		];
		$keys_members = explode(',', $_POST['keys']);
		$keys = [];
		foreach ($keys_members as $member) {
			$pos = strpos($member, ':');
			if ($pos === false) {
				$reason = 'Parameter `keys` expects a comma-separated list of key:value pairs.';
				return false;
			}
			$key = substr($member, 0, $pos);
			if (BeaconCommon::IsUUID($key) === false) {
				$reason = 'Key `' . $key . '` is not a v4 UUID.';
				return false;
			}
			$value = substr($member, $pos + 1);
			$keys[$key] = $value;
		}
		$project['EncryptionKeys'] = $keys;
		
		if (static::HookMultipartAddProjectValues($project, $reason) === false) {
			return false;
		}
		
		return self::SaveFromArray($project, $user, $_FILES['contents'], $reason);
	}
	
	public static function SaveFromContent(string $project_id, User $user, $file_content, string &$reason) {
	}
	
	protected static function HookRowSaveData(array $project, array &$row_values) {
	}
	
	protected static function SaveFromArray(array $project, User $user, $contents, string &$reason) {
		$project_version = intval($project['Version']);
		if ($project_version < 2) {
			$reason = 'Version 1 projects are no longer not accepted.';
			return false;
		}
		
		$database = BeaconCommon::Database();
		$project_id = $project['Identifier'];
		if (BeaconCommon::IsUUID($project_id) === false) {
			$reason = 'Project identifier is not a v4 UUID.';
			return false;
		}
		$title = isset($project['Title']) ? $project['Title'] : '';
		$description = isset($project['Description']) ? $project['Description'] : '';
		$game_id = isset($project['GameID']) ? $project['GameID'] : 'Ark';
		
		// check if the project already exists
		$results = $database->Query('SELECT project_id, storage_path FROM ' . static::SchemaName() . '.' . static::TableName() . ' WHERE project_id = $1;', $project_id);
		$new_project = $results->RecordCount() == 0;
		$storage_path = null;
		
		// confirm write permission of the project
		if ($new_project == false) {
			$storage_path = $results->Field('storage_path');
			
			$results = $database->Query('SELECT role, owner_id FROM ' . static::SchemaName() . '.' . static::AllowedTableName() . ' WHERE project_id = $1 AND user_id = $2;', $project_id, $user->UserID());
			if ($results->RecordCount() == 0) {
				$reason = 'Access denied for project ' . $project_id . '.';
				return false;
			}
			$role = $results->Field('role');
			$owner_id = $results->Field('owner_id');
		} else {
			$storage_path = static::GenerateCloudStoragePath($project_id);
			
			if ($user->IsChildAccount()) {
				$role = 'Team';
				$owner_id = $user->ParentAccountID();
			} else {
				$role = 'Owner';
				$owner_id = $user->UserID();
			}
		}
		
		$guests_to_add = [];
		$guests_to_remove = [];
		if (isset($project['EncryptionKeys']) && is_array($project['EncryptionKeys']) && BeaconCommon::IsAssoc($project['EncryptionKeys'])) {
			$encryption_keys = $project['EncryptionKeys'];
			$allowed_users = array_keys($encryption_keys);
			
			$desired_guests = [];
			$results = $database->Query('SELECT user_id FROM users WHERE user_id = ANY($1) AND user_id != $2;', '{' . implode(',', $allowed_users) . '}', $owner_id);
			while (!$results->EOF()) {
				$desired_guests[] = $results->Field('user_id');
				$results->MoveNext();
			}
			
			$current_guests = [];
			$results = $database->Query('SELECT user_id FROM ' . static::SchemaName() . '.' . static::GuestTableName() . ' WHERE project_id = $1;', $project_id);
			while (!$results->EOF()) {
				$current_guests[] = $results->Field('user_id');
				$results->MoveNext();
			}
			
			$guests_to_add = array_diff($desired_guests, $current_guests);
			$guests_to_remove = array_diff($current_guests, $desired_guests);
			
			if ($role !== 'Owner' && (count($guests_to_add) > 0 || count($guests_to_remove) > 0)) {
				$reason = 'Only the owner may add or remove users.';
				return false;
			}
		}
		
		if (BeaconCloudStorage::PutFile($storage_path, $contents) === false) {
			$reason = 'Unable to upload project to cloud storage platform.';
			return false;
		}
		
		try {
			$row_values = [
				'title' => $title,
				'description' => $description,
				'console_safe' => true,
				'game_specific' => '{}',
				'game_id' => $game_id
			];
			static::HookRowSaveData($project, $row_values);
			
			$placeholder = 3;
			$values = [$project_id, $owner_id];
			
			$database->BeginTransaction();
			if ($new_project) {
				$columns = ['project_id', 'user_id', 'last_update', 'storage_path'];
				$values[] = $storage_path;
				$placeholders = ['$1', '$2', 'CURRENT_TIMESTAMP', '$3'];
				$placeholder++;
				foreach ($row_values as $column => $value) {
					$columns[] = $database->EscapeIdentifier($column);
					$values[] = $value;
					$placeholders[] = '$' . strval($placeholder);
					$placeholder++;
				}
				
				$database->Query('INSERT INTO ' . static::SchemaName() . '.' . static::TableName() . ' (' . implode(', ', $columns) . ') VALUES (' . implode(', ', $placeholders) . ');', $values);
			} else {
				$assignments = ['revision = revision + 1', 'last_update = CURRENT_TIMESTAMP', 'deleted = FALSE'];
				foreach ($row_values as $column => $value) {
					$assignments[] = $database->EscapeIdentifier($column) . ' = $' . strval($placeholder);
					$values[] = $value;
					$placeholder++;
				}
				
				$database->Query('UPDATE ' . static::SchemaName() . '.' . static::TableName() . ' SET ' . implode(', ', $assignments) . ' WHERE project_id = $1 AND user_id = $2;', $values);
			}
			foreach ($guests_to_add as $guest_id) {
				$database->Query('INSERT INTO ' . static::SchemaName() . '.' . static::GuestTableName() . ' (project_id, user_id) VALUES ($1, $2);', $project_id, $guest_id);
			}
			foreach ($guests_to_remove as $guest_id) {
				$database->Query('DELETE FROM ' . static::SchemaName() . '.' . static::GuestTableName() . ' WHERE project_id = $1 AND user_id = $2;', $project_id, $guest_id);
			}
			$database->Commit();
		} catch (Exception $err) {
			$reason = 'Database error: ' . $err->getMessage();
			return false;
		}
		
		return true;
	}
	
	public function Versions(): array {
		$versions = BeaconCloudStorage::VersionsForFile($this->storage_path);
		if ($versions === false) {
			return [];
		}
		$api_path = $this->ResourceURL();
		$api_query = '';
		$pos = strpos($api_path, '?');
		if ($pos !== false) {
			$api_query = substr($api_path, $pos + 1);
			$api_path = substr($api_path, 0, $pos);
		}
		if ($api_query !== '') {
			$api_query = '?' . $api_query;
		}
		for ($idx = 0; $idx < count($versions); $idx++) {
			$url = $this->ResourceURL();
			$versions[$idx]['resource_url'] = $api_path . '/versions/' . urlencode($versions[$idx]['version_id']) . $api_query;
		}
		return $versions;
	}
}
	
?>
