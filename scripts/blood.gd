extends ColorRect

@export var speed = 700.0
@export var end_radius = 1500.0

var blood_radius := 0.0
var blood_position = null

func _init() -> void:
	set_process(true)
	
func trigger_effect(gpos: Vector2):
	
	blood_radius = 0.0
	blood_position = gpos+get_viewport_rect().size/2.0
	set_instance_shader_parameter("center_position",  blood_position)
	set_instance_shader_parameter("effect_radius", blood_radius)
	
func _process(delta: float) -> void:
	if blood_position != null and blood_radius < end_radius:
		blood_radius += speed*delta
		set_instance_shader_parameter("effect_radius", blood_radius)
