extends "res://scripts/TankController.gd"

onready var parent = get_parent()

export (float) var gun_rotation_speed
export (int) var detect_radius

var target = null

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func _process(delta):
	if target:
		var target_direction = (target.global_position - global_position).normalized()
		var current_direction = Vector2(1, 0).rotated($Gun.global_rotation)
		$Gun.global_rotation = current_direction.linear_interpolate(target_direction, gun_rotation_speed * delta).angle()
		if target_direction.dot(current_direction) > 0.9:
			shoot()

func move(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + movement_speed * delta)
		position = Vector2()

func _on_DetectRadius_body_entered(body):
	if body.name == "PlayerTank":
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null
