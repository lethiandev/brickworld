extends "./brick_generator.gd"
tool

func _generate_brick_resource(p_size: Vector3) -> Resource:
	var brick_base = SharedConstants.BRICK_BASE
	var brick_scale = SharedConstants.BRICK_SCALE
	return create_block_shape(p_size, brick_base, brick_scale)

func create_block_shape(p_size: Vector3, p_base: Vector3, p_scale: float) -> Shape:
	var brick_units = p_size * p_base
	var brick_size = brick_units * p_scale
	
	var shape = ConvexPolygonShape.new()
	shape.points = _generate_block_shape_vertices(brick_size)
	shape.margin = 0.01
	
	return shape

func _generate_block_shape_vertices(p_size: Vector3) -> PoolVector3Array:
	var vertices = PoolVector3Array()
	# Top vertices side
	vertices.push_back(Vector3(0.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 1.0, 1.0) * p_size)
	# Bottom vertices side
	vertices.push_back(Vector3(0.0, 0.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 1.0) * p_size)
	return vertices
