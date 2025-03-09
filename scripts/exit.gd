extends ColorRect

@export var speed = 700.0

var exit_radius := 0.0
var exit_position = null

func _init() -> void:
	set_process(true)
	
func trigger_effect(gpos: Vector2):
	
	exit_radius = 1500.0
	exit_position = gpos+get_viewport_rect().size/2.0
	set_instance_shader_parameter("center_position",  exit_position)
	set_instance_shader_parameter("effect_radius", exit_radius)
	
func _process(delta: float) -> void:
	if exit_position != null and exit_radius >= 0.0:
		exit_radius -= speed*delta
		set_instance_shader_parameter("effect_radius", exit_radius)
