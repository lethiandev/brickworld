extends KinematicBody

const ACCELERATION = 20.0
const DECELERATION = 20.0
const MAX_SPEED = 2.0

const GRAVITY = Vector3.DOWN * 10.0
const SNAP = Vector3.DOWN * 0.01

var linear_velocity: Vector3 = Vector3()
var floor_normal: Vector3 = Vector3()
var motion_direction: Vector3 = Vector3()
var motion_speed: float = 0.0
var air_frames: int = 0

func _physics_process(p_delta: float) -> void:
	linear_velocity += GRAVITY * p_delta
	
	var input_forward = _get_forward_input()
	var input_strafe = _get_strafe_input()
	
	var camera_basis = _get_camera_basis()
	
	var motion = Vector3()
	motion += camera_basis.z * input_forward
	motion += camera_basis.x * input_strafe
	
	motion.y = 0.0
	motion = motion.normalized()
	
	if not motion == Vector3():
		var accel = ACCELERATION * p_delta
		motion_direction = motion
		motion_speed += min(accel, max(0, MAX_SPEED - motion_speed))
	else:
		var decel = DECELERATION * p_delta
		motion_speed -= min(decel, motion_speed)
	
	if motion_speed > 0.0:
		var motion_velocity = motion_direction * motion_speed
		move_and_slide(motion_velocity, Vector3.UP, true)
	
	var slope_angle = deg2rad(66)
	var snap = SNAP if linear_velocity.y <= 0.0 else Vector3.ZERO
	var lv = move_and_slide_with_snap(linear_velocity, snap, Vector3.UP, true, 4, slope_angle)
	
	if is_on_floor():
		floor_normal = get_floor_normal()
		linear_velocity *= 0.7
		air_frames = 0
	else:
		floor_normal = Vector3.UP
		linear_velocity = lv
		linear_velocity.x *= 0.9
		linear_velocity.z *= 0.9
		air_frames += 1
	
	if Input.is_action_just_pressed("ui_select") and air_frames < 6:
		linear_velocity.y = 3.0
		linear_velocity -= GRAVITY * p_delta

func _get_forward_input() -> float:
	var forward = Input.get_action_strength("move_forward")
	var backward = Input.get_action_strength("move_backward")
	return backward - forward

func _get_strafe_input() -> float:
	var right = Input.get_action_strength("strafe_right")
	var left = Input.get_action_strength("strafe_left")
	return right - left

func _get_camera_basis() -> Basis:
	var camera = get_viewport().get_camera()
	return camera.global_transform.basis
