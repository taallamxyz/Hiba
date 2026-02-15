extends Control

func _ready() -> void:
	play_music_menu()

func play_sound_enemy():
	$SoundEnemy.play()
func play_sound_coin():
	$SoundCoin.play()
func play_sound_fall_zone():
	$SoundFallZone.play()
func play_sound_play_button():
	$SoundPlayButton.play()
func play_music_menu():
	$MusicMenu.play()
func stop_music_menu():
	$MusicMenu.stop()
func play_music_level():
	$MusicLevel.play()
func stop_music_level():
	$MusicLevel.stop()
