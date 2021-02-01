extends CollisionShape
tool

export(Vector3) var block_size: Vector3 = Vector3(2.0, 3.0, 4.0) \
	setget set_block_size, get_block_size

func set_block_size(p_size: Vector3) -> void:
	block_size = p_size
	shape = BlockServer.get_block_shape(p_size)

func get_block_size() -> Vector3:
	return block_size
