extends Sprite3D

var colns=5
var player_name="rebot"
var hearts= 3.5
var hamza = false

func _ready() -> void:
	pass
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	minion()
	if(hamza):
		print("hamza")
	else:
		print("hiba")
	if Input.is_action_pressed("ui_left"):
		rotate_y(.1)
	if Input.is_action_pressed("ui_right"):
		rotate_y(-.1)
		
func minion():
	print("BANANA!")
  
