extends Node2D

onready var player_marker = $PlayerMarker
onready var enemy_marker = $EnemyMarker
onready var wall_marker = $WallMarker

onready var icons = {
	"player": player_marker,
	"enemy": enemy_marker,
	"wall": wall_marker
}

var markers = {}

var player = null
var enemies = []

func _ready():
	player = get_parent().get_node("PlayerTank")
	var player_marker = icons["player"].duplicate()
	add_child(player_marker)
	player_marker.show()
	markers[player] = player_marker
	
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		var new_marker = icons["enemy"].duplicate()
		add_child(new_marker)
		new_marker.show()
		markers[enemy] = new_marker
		
	for room in get_parent().get_node("Obstacles").get_children():
		for obstacle in room.get_children():
			var new_marker = icons["wall"].duplicate()
			add_child(new_marker)
			new_marker.position = Vector2(obstacle.position.x/10, obstacle.position.y/10)
			new_marker.rotation = obstacle.rotation
			new_marker.show()
			markers[obstacle] = new_marker

func _process(delta):
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		if enemy in markers.keys():
			markers[enemy].position = Vector2(enemy.global_position.x/10, enemy.global_position.y/10)
	
	markers[player].position = Vector2(player.global_position.x/10, player.global_position.y/10)

func _on_object_removed(object):
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)
