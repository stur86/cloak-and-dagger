extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Collided")
	ShadowMaster.on_doorway_enter.emit()
