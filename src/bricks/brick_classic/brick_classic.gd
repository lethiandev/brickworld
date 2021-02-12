extends "res://bricks/brick_base/brick_base.gd"
tool

# Setter for brick size
# Also updates the brick data
func set_brick_size(p_size: Vector3) -> void:
	brick_size = p_size
	if is_inside_tree():
		_update_brick()

# Updates brick on ready event
func _ready() -> void:
	_update_brick()

# Update brick mesh and shape
# Uses brick generators if necessary
func _update_brick() -> void:
	var brick_mesh = BrickServer.get_brick_mesh(brick_size)
	var brick_shape = BrickServer.get_brick_shape(brick_size)
	
	$MeshInstance.mesh = brick_mesh
	$CollisionShape.shape = brick_shape
