extends Node

signal on_doorway_enter(position)
signal on_cloak_stabbed(position)


func restart_level():
	get_tree().reload_current_scene()
	
func next_level():
	pass
