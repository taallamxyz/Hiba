extends Area3D

const ROT_SPEED=2
@onready var audioPlayer = $AudioStreamPlayer3D
@onready var mesh = $MeshInstance3D
@onready var collision = $CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))
	#if has_overlapping_bodies():
		#queue_free()


func _on_body_entered(body: Node3D) -> void:
	audioPlayer.play()
	mesh.visible = false
	collision.set_deferred("disabled", true)
	await  audioPlayer.finished
	queue_free()
