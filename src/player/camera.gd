extends Camera

var target_angle: Vector2 = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		var relative = p_event.relative
		_add_rotation(relative)

func _add_rotation(p_rotation: Vector2) -> void:
	target_angle -= p_rotation * 0.01
	target_angle.y = clamp(target_angle.y, -PI * 0.49, PI * 0.49)
	_update_rotation()

func _update_rotation() -> void:
	var basis = Basis()
	basis = basis.rotated(Vector3.RIGHT, target_angle.y)
	basis = basis.rotated(Vector3.UP, target_angle.x)
	transform.basis = basis
