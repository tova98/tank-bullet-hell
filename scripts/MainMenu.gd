extends Node

func _ready():
	$AudioStreamPlayer.play()

func _on_Button_pressed():
	get_tree().change_scene("res://maps/Map.tscn")


func _on_Close_pressed():
	get_tree().quit()


func _on_About_pressed():
	$Settings.hide()
	if $Tutorial.visible:
		$Tutorial.hide()
	else:
		$Tutorial.show()

func _on_VolumeControl_value_changed(value):
	$AudioStreamPlayer.volume_db = value


func _on_SettingsButton_pressed():
	$Tutorial.hide()
	if $Settings.visible:
		$Settings.hide()
	else:
		$Settings.show()
