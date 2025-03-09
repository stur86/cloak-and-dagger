extends Node

signal on_doorway_enter(position)
signal on_cloak_stabbed(position)

const level_list: Array[PackedScene] = [
	preload("res://scenes/starting_room.tscn"),
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn"),
	preload("res://scenes/level_3.tscn"),
	preload("res://scenes/ending_room.tscn")
]

var current_level: int = 0

func _init() -> void:
	on_doorway_enter.connect(self._doorway_handler)
	on_cloak_stabbed.connect(self._stab_handler)
	
func _stab_handler(_pos: Vector2) -> void:
	await get_tree().create_timer(1.5).timeout
	restart_level()	
	
func _doorway_handler(_pos: Vector2) -> void:
	await get_tree().create_timer(2.0).timeout
	next_level()

func restart_level():
	var lv = get_node("/root/Game/Level")
	lv.remove_child(lv.get_child(0))
	lv.add_child(level_list[current_level].instantiate())
	
func next_level():
	current_level += 1
	restart_level()
