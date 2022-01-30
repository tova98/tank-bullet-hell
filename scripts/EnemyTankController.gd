extends "res://scripts/TankController.gd"

onready var parent = get_parent()

export (float) var gun_rotation_speed
export (int) var detect_radius
export (int) var follow_radius

var target = null
var will_follow = false

var player = null

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	$FollowRadius/CollisionShape2D.shape.radius = follow_radius

func _process(delta):
	if target:
		var target_direction = (target.global_position - global_position).normalized()
		var current_direction = Vector2(1, 0).rotated($Gun.global_rotation)
		$Gun.global_rotation = current_direction.linear_interpolate(target_direction, gun_rotation_speed * delta).angle()
		if target_direction.dot(current_direction) > 0.9:
			shoot()

func move(delta):
	if will_follow:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * movement_speed
		rotation = lerp_angle(rotation, dir.angle(), 0.1)
	else:
		velocity = Vector2()


func _on_DetectRadius_body_entered(body):
	if body.name == "PlayerTank":
		will_follow = false

func _on_DetectRadius_body_exited(body):
	if body == target:
		will_follow = true

func _on_FollowRadius_body_entered(body):
	if body.name == "PlayerTank":
		target = body
		will_follow = true

func _on_FollowRadius_body_exited(body):
	if body.name == "PlayerTank":
		target = null
		will_follow = false
