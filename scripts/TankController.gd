extends KinematicBody2D

export (float) var gun_cooldown
export (int) var max_health
export (int) var movement_speed
export (int) var rotation_speed

export (PackedScene) var Bullet

signal shoot
signal health_changed
signal removed
signal add_score

var velocity = Vector2()
var can_shoot = true
var health
var alive = true

func _ready():
	alive = true
	health = max_health
	emit_signal('health_changed', health * 100/max_health)
	$Cooldown.wait_time = gun_cooldown

func move(delta):
	pass

func _physics_process(delta):
	move(delta)
	if velocity != Vector2():
		if $TankDrive.playing == false:
			$TankDrive.playing = true
	else:
		$TankDrive.playing = false
	move_and_slide(velocity)

func shoot():
	if can_shoot and alive:
		can_shoot = false
		$Cooldown.start()
		var dir = Vector2(1, 0).rotated($Gun.global_rotation)
		if "BossTank" in name:
			for i in range(2):
				var spread_rotation = -0.2 + i * 0.2
				emit_signal('shoot', Bullet, $Gun/FirePosition.global_position, dir.rotated(spread_rotation))
		else:
			emit_signal('shoot', Bullet, $Gun/FirePosition.global_position, dir)
		$ShootSound.play()
		$AnimationPlayer.play("Flash")

func take_damage(damage):
	health -= damage
	emit_signal('health_changed', health * 100/max_health)
	if health <= 0 and alive:
		alive = false
		explode()

func explode():
	if name != "PlayerTank":
		emit_signal("removed", self)
		emit_signal("add_score", 100)
		$Hull.hide()
		$Gun.hide()
		$CollisionShape2D.queue_free()
		$Explosion.show()
		$ExplosionSound.play()
		$Explosion.play()
	else:
		get_tree().paused = true
		var score = get_node("/root/Map/UI/Score").bbcode_text
		get_node("/root/Map/UI/GameOver/Score").bbcode_text = "[center]Score: " + str(int(score)) + "[/center]"
		get_node("/root/Map/UI/GameOver").show()

func _on_Cooldown_timeout():
	can_shoot = true

func _on_Explosion_animation_finished():
	$Explosion.hide()
	
func _on_ExplosionSound_finished():
	queue_free()
