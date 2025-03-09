extends CharacterBody2D

@export var speed: float = 200.0
@export var vel_smoothing: float = 0.6

var is_alive = true

func _init() -> void:
	set_physics_process(true)
	
func _physics_process(_delta: float) -> void:
	if is_alive:
		var dx = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
		var dy = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")		
		velocity = velocity*(1.0-vel_smoothing)+vel_smoothing*Vector2(dx, dy)*speed
	else:
		velocity = Vector2.ZERO

	if move_and_slide() and is_alive:
		var n = get_slide_collision_count()
		for i in range(n):
			var c = get_slide_collision(i)
			if c.get_collider().is_in_group("Daggers"):
				ShadowMaster.on_cloak_stabbed.emit(global_position)
				is_alive = false
				$Splatter.play()
