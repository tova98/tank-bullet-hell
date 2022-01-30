extends StaticBody2D

onready var score = get_node("/root/Map/UI/Score")
onready var console = get_node("/root/Map/UI/Console")

export (int) var cost

var in_area = false

func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("open_gate"):
			if int(score.bbcode_text) >= cost:
				if name == "EndGate":
					if get_tree().get_nodes_in_group("Enemies").size() > 0:
						var message = "You need to have killed all enemies to open this gate!"
						console.bbcode_text = "[center]" + message + "[/center]"
						console.get_node("Timer").start()
					else:
						score.bbcode_text = "[right]" + str(int(score.bbcode_text) - cost) + "[/right]"
						queue_free()
				else:
					score.bbcode_text = "[right]" + str(int(score.bbcode_text) - cost) + "[/right]"
					queue_free()
			else:
				var message = "You need " + str(cost) + " points to open this gate!"
				console.bbcode_text = "[center]" + message + "[/center]"
				console.get_node("Timer").start()


func _on_DetectRadius_body_entered(body):
	if body.name == "PlayerTank":
		in_area = true


func _on_DetectRadius_body_exited(body):
	in_area = false
