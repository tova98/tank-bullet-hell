extends Node


func _ready():
	get_tree().paused = false
	$PlayerTank.connect("health_changed", $UI/HealthBar, "update_health")
	Input.set_custom_mouse_cursor(load("res://assets/crosshair.png"), Input.CURSOR_ARROW, Vector2())
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.connect("removed", $Minimap, "_on_object_removed")
		enemy.connect("add_score", $UI/Score, "change_score")

func _process(delta):
	minimap_control()

func minimap_control():
	var map_pos = Vector2($PlayerTank/Camera2D.get_camera_screen_center().x - 450, $PlayerTank/Camera2D.get_camera_screen_center().y - 170)
	$Minimap.position = map_pos
	if Input.is_action_just_pressed("minimap"):
		if $Minimap.visible:
			$Minimap.hide()
		else:
			$Minimap.show()

func _on_Tank_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	$Bullets.add_child(b)
	b.start(_position, _direction)


func _on_Timer_timeout():
	$UI/Console.bbcode_text = "[center][/center]"


func _on_EndGame_body_entered(body):
	if body.name == "PlayerTank":
		get_tree().paused = true
		$UI/VictoryScreen.show()
