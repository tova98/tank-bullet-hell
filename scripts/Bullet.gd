extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = lifetime
	$Timer.start()
	velocity = _direction * speed

func _process(delta):
	position += velocity * delta

func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play("gun")

func _on_Bullet_body_entered(body):
	if not 'Plasma' in name:
		explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)


func _on_Timer_timeout():
	explode()

func _on_Explosion_animation_finished():
	queue_free()
