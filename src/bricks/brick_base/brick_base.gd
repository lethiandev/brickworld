extends StaticBody
class_name BrickBase
tool

export var brick_size: Vector3 = Vector3() \
	setget set_brick_size, get_brick_size

# Calculates brick offset from the center in world coords
# Returns vector representing offset from the brick center
func get_brick_world_offset() -> Vector3:
	var world_size = get_brick_world_size()
	return world_size * 0.5

# Calculates brick size in world coords
# Returns vector representing real size of the brick in the world
func get_brick_world_size() -> Vector3:
	var bbase = SharedConstants.BRICK_BASE
	var bscale = SharedConstants.BRICK_SCALE
	return brick_size * bbase * bscale

# Setter for the brick size
# Can be overrided by derived scripts
func set_brick_size(p_size: Vector3) -> void:
	brick_size = p_size

# Getter for the brick size
func get_brick_size() -> Vector3:
	return brick_size
