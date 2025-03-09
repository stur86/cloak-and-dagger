extends CharacterBody2D

@export var speed: float = 200.0
@export var vel_smoothing: float = 0.6

func _init() -> void:
	set_physics_process(true)
	
func _physics_process(_delta: float) -> void:
	var dx = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var dy = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	
	velocity = velocity*(1.0-vel_smoothing)+vel_smoothing*Vector2(dx, dy)*speed

	move_and_slide()
