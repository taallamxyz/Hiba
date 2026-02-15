extends CharacterBody3D


const SPEED = 5.0
@export var JUMP_VELOCITY = 10
@onready var cameraController = $CameraController

var xform : Transform3D


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("cam_left"):
		cameraController.rotate_y(deg_to_rad(-30))
	if Input.is_action_just_pressed("cam_right"):
		cameraController.rotate_y(deg_to_rad(30))
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$SoundJump.play()
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("RobotArmature|Robot_Jump")

	# Get the input direction and handle the movement/deceleration.

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (cameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir != Vector2(0,0):
		$RootNode.rotation_degrees.y = cameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90
	
	if is_on_floor():
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform,.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, .3)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$AnimationPlayer.play("RobotArmature|Robot_Running")
	else:
		$AnimationPlayer.play("RobotArmature|Robot_Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	$CameraController.position = lerp($CameraController.position, position, .08)
	
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()

func bounce():
	velocity.y = JUMP_VELOCITY

func _on_fall_zone_body_entered(body: Node3D) -> void:
	
	SoundManger.play_sound_fall_zone()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menus/menu_game_over.tscn")

func play_death_animation():
	$AnimationPlayer.play("RobotArmature|Robot_Death")
