extends MarginContainer

var light_shell = preload("res://scenes/bullets/PlayerLightBullet.tscn")
var medium_shell = preload("res://scenes/bullets/PlayerMediumBullet.tscn")
var shotgun_shell = preload("res://scenes/bullets/PlayerShotgunBullet.tscn")
var plasma_shell = preload("res://scenes/bullets/PlayerPlasmaBullet.tscn")

var flash_shell = preload("res://assets/tank/FlashShell.png")
var flash_shotgun = preload("res://assets/tank/FlashShotgun.png")
var flash_plasma = preload("res://assets/tank/FlashPlasma.png")

onready var shells = $ShellContainer.get_children()

var shell_map = {}
var flash_map = {}

signal shell_changed

func _ready():
	for shell in shells:
		if "Light" in shell.name:
			shell_map[shell] = light_shell
			flash_map[shell] = flash_shell
		if "Medium" in shell.name:
			shell_map[shell] = medium_shell
			flash_map[shell] = flash_shell
		if "Shotgun" in shell.name:
			shell_map[shell] = shotgun_shell
			flash_map[shell] = flash_shotgun
		if "Plasma" in shell.name:
			shell_map[shell] = plasma_shell
			flash_map[shell] = flash_plasma

func _process(delta):
	if Input.is_action_just_released("gun_scroll_down"):
		var collected_shells = []
		
		for shell in shells:
			if shell.visible:
				collected_shells.append(shell)

		for i in range(collected_shells.size()):
			if collected_shells[i].get_node("Selected").visible:
				var pos = i + 1
				if pos >= collected_shells.size():
					pos = 0
				collected_shells[i].get_node("Selected").visible = false
				collected_shells[pos].get_node("Selected").visible = true
				emit_signal('shell_changed', shell_map[collected_shells[pos]], flash_map[collected_shells[pos]])
				break
				
	
	if Input.is_action_just_released("gun_scroll_up"):
		var collected_shells = []
		
		for shell in shells:
			if shell.visible:
				collected_shells.append(shell)

		for i in range(collected_shells.size()):
			if collected_shells[i].get_node("Selected").visible:
				var pos = i - 1
				if pos < 0:
					pos = collected_shells.size() - 1
				collected_shells[i].get_node("Selected").visible = false
				collected_shells[pos].get_node("Selected").visible = true
				emit_signal('shell_changed', shell_map[collected_shells[pos]], flash_map[collected_shells[pos]])
				break
	
