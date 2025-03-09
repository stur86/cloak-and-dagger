@tool
extends Node2D

@export var wall_width := 128.0:
	set(w):
		wall_width = w
		_update_wall()
		_update_shadow()

@export var wall_height := 128.0:
	set(h):
		wall_height = h
		_update_wall()
		
@export var shadow_length := 100.0:
	set(l):
		shadow_length = l
		_update_shadow()

@export_range(-90.0, 90.0) var shadow_angle := 0.0:
	set(a):
		shadow_angle = a
		_update_shadow()
		
func _enter_tree() -> void:
	_update_wall()
	_update_shadow()

func _update_wall():
	var sx = wall_width/128.0
	var sy = wall_height/128.0
	$Wall.scale = Vector2(sx, sy)
	
func _update_shadow():
	var y0 = wall_height/2.0
	var x00 = -wall_width/2.0
	var x01 = -x00
	var y1 = y0+shadow_length
	var dx = shadow_length*tan(deg_to_rad(shadow_angle))
	var x10 = x00-dx
	var x11 = x01-dx
	
	# Now set the polygons
	var shadow_poly = PackedVector2Array(
		[Vector2(x00, y0), Vector2(x01, y0), Vector2(x11, y1), Vector2(x10, y1)]
	)
	# Drawn
	$Shadow/Polygon2D.polygon = shadow_poly;
	# And same to the collision shape
	$Shadow/CollisionPolygon2D.polygon = shadow_poly;
