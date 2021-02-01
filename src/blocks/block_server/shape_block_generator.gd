extends Reference
tool

var block_scale: Vector3 = Vector3(1.0, 1.0, 1.0)

func create_block_shape(p_size: Vector3) -> Shape:
	var shape = ConvexPolygonShape.new()
	
	var block_size = p_size
	var world_size = block_size * block_scale
	shape.points = _generate_block_shape_vertices(world_size)
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
