tool
extends StaticBody2D

var border = preload("res://assets/obstacles/Border.png")
var gate = preload("res://assets/obstacles/Gate.png")
var container1 = preload("res://assets/obstacles/Container1.png")
var container2 = preload("res://assets/obstacles/Container2.png")
var container3 = preload("res://assets/obstacles/Container3.png")

enum Obstacles {border, gate, container1, container2, container3}

var textures = {
	Obstacles.border: border,
	Obstacles.gate: gate,
	Obstacles.container1: container1,
	Obstacles.container2: container2,
	Obstacles.container3: container3
}

var sizes = {
	Obstacles.border: Vector2(130, 15),
	Obstacles.gate: Vector2(130, 15),
	Obstacles.container1: Vector2(130, 65),
	Obstacles.container2: Vector2(130, 65),
	Obstacles.container3: Vector2(130, 65)
}

export (Obstacles) var type setget _update

func _update(_type):
	type = _type
	$Sprite.texture = textures[type]
	$Sprite
	var rect = RectangleShape2D.new()
	rect.extents = sizes[type]
	$CollisionShape2D.shape = rect
