tool
extends Area2D

enum Pickups {medium, shotgun, plasma, health}

var medium = preload("res://assets/tank/MediumPickup.png")
var shotgun = preload("res://assets/tank/ShotgunPickup.png")
var plasma = preload("res://assets/tank/PlasmaPickup.png")
var health = preload("res://assets/tank/HealthPickup.png")

export (Pickups) var type setget _update

func _on_Pickup_body_entered(body):
	match type:
		Pickups.medium:
			get_node("/root/Map/UI/Shells/ShellContainer/MediumShell").visible = true
		Pickups.shotgun:
			get_node("/root/Map/UI/Shells/ShellContainer/ShotgunShell").visible = true
		Pickups.plasma:
			get_node("/root/Map/UI/Shells/ShellContainer/PlasmaShell").visible = true
		Pickups.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(10, 30)))
	queue_free()

func _update(_type):
	type = _type
	match _type:
		Pickups.medium:
			$Sprite.texture = medium
		Pickups.shotgun:
			$Sprite.texture = shotgun
		Pickups.plasma:
			$Sprite.texture = plasma
		Pickups.health:
			$Sprite.texture = health
