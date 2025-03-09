extends Node2D

@export var patrol_angle: float = 20.0
@export var patrol_speed: float = 1.0

@export var attack_speed: float = 2.0

var patrol_phi = 0.0
var patrol_theta = 0.0
var patrol_angle_center = 0.0

var attack_distance = null
var attack_phase = null

func _enter_tree() -> void:
	patrol_angle_center = rotation
	$DaggerBody.position = Vector2.ZERO
	$DaggerBody.rotation = 0.0
	set_physics_process(true)
	
	ShadowMaster.on_doorway_enter.connect(self._on_player_victory)

func _on_player_victory(_pos: Vector2) -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	
	if attack_distance == null:
		_patrol(delta)
	else:
		_attack(delta)

func _patrol(delta: float) -> void:
	
	patrol_phi += patrol_speed*delta
	patrol_phi = fmod(patrol_phi, 2*PI)
	patrol_theta = sin(patrol_phi)*deg_to_rad(patrol_angle)
	
	rotation = patrol_angle_center+patrol_theta
	
	if $DaggerBody/RayCast2D.is_colliding():
		var b: Node2D = $DaggerBody/RayCast2D.get_collider()
		# Is it the player?
		if b and b.is_in_group("Player") and b.is_alive:
			var p = $DaggerBody/RayCast2D.get_collision_point()
			var d = (p-global_position).length()
			attack_distance = d
			attack_phase = 0.0

func _attack(delta: float) -> void:
	
	attack_phase += delta*attack_speed

	if attack_phase >= PI:
		$DaggerBody.position = Vector2.ZERO
		attack_phase = null
		attack_distance = null
		return

	$DaggerBody.position = Vector2(attack_distance*pow(sin(attack_phase), 4.0), 0.0)
	
