extends CharacterBody3D


var speed = 3.0

@export var direction := Vector3(1,0,0)
@export var turn_at_edges := false

var turning = false

func _ready() -> void:
	$AnimationPlayer.play("MonsterArmature|Walk")


func _physics_process(delta: float) -> void:
	
	velocity.x = speed*direction.x
	velocity.z = speed*direction.z
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()
	if is_on_wall() and not turning:
		turn_around()
	if not $RayCast3D.is_colliding() and is_on_floor() and not turning and turn_at_edges:
		turn_around()
		
func turn_around():
	turning = true
	var temp_direction = direction
	direction = Vector3.ZERO
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0,180,0), .6).as_relative()
	await get_tree().create_timer(.6).timeout
	direction.x = temp_direction.x * -1
	direction.z = temp_direction.z * -1
	turning = false


func _on_side_checker_body_entered(body: Node3D) -> void:
	SoundManger.play_sound_enemy()
	$SideChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	body.bounce()
	await get_tree().create_timer(.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menus/menu_game_over.tscn")


func _on_top_checker_body_entered(body: Node3D) -> void:
	$SoundDeath.play()
	$AnimationPlayer.play("MonsterArmature|Death")
	body.bounce()
	$SideChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	direction = Vector3.ZERO
	speed = 0
	await get_tree().create_timer(1).timeout
	queue_free()
