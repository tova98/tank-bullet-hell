extends Panel

func _on_Button_pressed():
	get_tree().change_scene("res://maps/Map.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
