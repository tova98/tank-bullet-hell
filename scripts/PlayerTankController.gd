extends "res://scripts/TankController.gd"

func _ready():
	get_parent().get_node("UI/Shells").connect("shell_changed", self, "_on_shell_changed")

func move(delta):
	$Gun.look_at(get_global_mouse_position())
	
	var rotation_direction = 0
	
	if Input.is_action_pressed("rotate_right"):
		rotation_direction += 1
	if Input.is_action_pressed("rotate_left"):
		rotation_direction -= 1
	rotation += rotation_speed * rotation_direction * delta
	velocity = Vector2()
	if Input.is_action_pressed("go_forward"):
		velocity = Vector2(movement_speed, 0).rotated(rotation)
	if Input.is_action_pressed("go_back"):
		velocity = Vector2(-movement_speed/2, 0).rotated(rotation)
	if Input.is_action_just_pressed("shoot"):
		shoot()

func heal(amount):
	health += amount
	if health > max_health:
		health = max_health
	emit_signal('health_changed', health * 100/max_health)

func _on_shell_changed(shell, flash):
	Bullet = shell
	$Gun/Flash.texture = flash
