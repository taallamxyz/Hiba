extends Control

func _ready() -> void:
	SoundManger.stop_music_level()
	SoundManger.play_music_menu()
func _on_button_pressed() -> void:
	SoundManger.stop_music_menu()
	SoundManger.play_sound_play_button()
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")
