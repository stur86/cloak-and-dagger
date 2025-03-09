extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.is_alive:
		body.is_alive = false
		ShadowMaster.on_doorway_enter.emit(body.global_position)
		$Lock.play()
