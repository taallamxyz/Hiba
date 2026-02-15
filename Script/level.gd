extends Node3D

var coins_count = 0

func _ready() -> void:
	Globals.coins = 0
	coins_count = $World/Coins.get_child_count()
	SoundManger.play_music_level()
	
func _process(delta: float) -> void:
	if Globals.coins >= coins_count:
		get_tree().change_scene_to_file("res://Scenes/Menus/menu_win.tscn")
