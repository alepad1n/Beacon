<?php

namespace Ark;

class Project extends \BeaconAPI\Ark\Project {
	public function jsonSerialize(): mixed {
		return [
			'document_id' => $this->project_id,
			'user_id' => $this->user_id,
			'owner_id' => ($this->role === 'Owner' ? $this->user_id : '00000000-0000-0000-0000-000000000000'),
			'name' => $this->title,
			'description' => $this->description,
			'revision' => $this->revision,
			'download_count' => $this->download_count,
			'last_updated' => $this->last_update->format('Y-m-d H:i:sO'),
			'console_safe' => $this->console_safe,
			'map_mask' => $this->MapMask(),
			'difficulty' => $this->DifficultyValue(),
			'resource_url' => $this->ResourceURL()
		];
	}
}

?>
