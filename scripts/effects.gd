extends CanvasLayer

func _enter_tree() -> void:
	ShadowMaster.on_cloak_stabbed.connect(self._on_death)
	ShadowMaster.on_doorway_enter.connect(self._on_exit)

func _on_exit(gpos: Vector2):
	$Exit.trigger_effect(gpos)
	
func _on_death(gpos: Vector2):
	$Blood.trigger_effect(gpos)
