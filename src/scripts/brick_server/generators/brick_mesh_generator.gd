extends "./brick_generator.gd"
tool

func _generate_brick_resource(p_size: Vector3) -> Resource:
	var brick_base = SharedConstants.BRICK_BASE
	var brick_scale = SharedConstants.BRICK_SCALE
	return _create_brick_mesh(p_size, brick_base, brick_scale)

func _create_brick_mesh(p_size: Vector3, p_base: Vector3, p_scale: float) -> Mesh:
	var brick_units = p_size * p_base
	var brick_size = brick_units * p_scale
	
	var meshdata = Array()
	meshdata.resize(Mesh.ARRAY_MAX)
	meshdata[Mesh.ARRAY_VERTEX] = _generate_brick_mesh_vertices(brick_size)
	meshdata[Mesh.ARRAY_NORMAL] = _generate_brick_mesh_normals()
	meshdata[Mesh.ARRAY_TANGENT] = _generate_brick_mesh_tangents()
	meshdata[Mesh.ARRAY_TEX_UV] = _generate_brick_mesh_uv1(brick_units)
	meshdata[Mesh.ARRAY_TEX_UV2] = _generate_brick_mesh_uv2()
	meshdata[Mesh.ARRAY_INDEX] = _generate_brick_mesh_indices()
	
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meshdata)
	
	return mesh

func _generate_brick_mesh_vertices(p_size: Vector3) -> PoolVector3Array:
	var vertices = PoolVector3Array()
	# Top face
	vertices.push_back(Vector3(0.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 1.0, 1.0) * p_size)
	# Bottom face
	vertices.push_back(Vector3(0.0, 0.0, 1.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 1.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 0.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 0.0) * p_size)
	# Front face
	vertices.push_back(Vector3(0.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 1.0) * p_size)
	# Back face
	vertices.push_back(Vector3(1.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(0.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 0.0) * p_size)
	# Right side face
	vertices.push_back(Vector3(1.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(1.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 0.0) * p_size)
	vertices.push_back(Vector3(1.0, 0.0, 1.0) * p_size)
	# Left side face
	vertices.push_back(Vector3(0.0, 1.0, 0.0) * p_size)
	vertices.push_back(Vector3(0.0, 1.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 1.0) * p_size)
	vertices.push_back(Vector3(0.0, 0.0, 0.0) * p_size)
	return vertices

func _generate_brick_mesh_normals() -> PoolVector3Array:
	var normals = PoolVector3Array()
	# Top face
	normals.push_back(Vector3(0.0, 1.0, 0.0))
	normals.push_back(Vector3(0.0, 1.0, 0.0))
	normals.push_back(Vector3(0.0, 1.0, 0.0))
	normals.push_back(Vector3(0.0, 1.0, 0.0))
	# Bottom face
	normals.push_back(Vector3(0.0, -1.0, 0.0))
	normals.push_back(Vector3(0.0, -1.0, 0.0))
	normals.push_back(Vector3(0.0, -1.0, 0.0))
	normals.push_back(Vector3(0.0, -1.0, 0.0))
	# Front face
	normals.push_back(Vector3(0.0, 0.0, 1.0))
	normals.push_back(Vector3(0.0, 0.0, 1.0))
	normals.push_back(Vector3(0.0, 0.0, 1.0))
	normals.push_back(Vector3(0.0, 0.0, 1.0))
	# Back face
	normals.push_back(Vector3(0.0, 0.0, -1.0))
	normals.push_back(Vector3(0.0, 0.0, -1.0))
	normals.push_back(Vector3(0.0, 0.0, -1.0))
	normals.push_back(Vector3(0.0, 0.0, -1.0))
	# Right face
	normals.push_back(Vector3(1.0, 0.0, 0.0))
	normals.push_back(Vector3(1.0, 0.0, 0.0))
	normals.push_back(Vector3(1.0, 0.0, 0.0))
	normals.push_back(Vector3(1.0, 0.0, 0.0))
	# Left face
	normals.push_back(Vector3(-1.0, 0.0, 0.0))
	normals.push_back(Vector3(-1.0, 0.0, 0.0))
	normals.push_back(Vector3(-1.0, 0.0, 0.0))
	normals.push_back(Vector3(-1.0, 0.0, 0.0))
	return normals

func _generate_brick_mesh_tangents() -> PoolRealArray:
	var tangents = PoolRealArray()
	# Top face
	for i in range(4):
		tangents.push_back(1.0)
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(1.0)
	# Bottom face
	for i in range(4):
		tangents.push_back(1.0)
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(1.0)
	# Front face
	for i in range(4):
		tangents.push_back(1.0)
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(1.0)
	# Back face
	for i in range(4):
		tangents.push_back(-1.0)
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(1.0)
	# Right side face
	for i in range(4):
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(-1.0)
		tangents.push_back(1.0)
	# Left side face
	for i in range(4):
		tangents.push_back(0.0)
		tangents.push_back(0.0)
		tangents.push_back(1.0)
		tangents.push_back(1.0)
	return tangents

func _generate_brick_mesh_uv1(p_size: Vector3) -> PoolVector2Array:
	var xz = Vector2(p_size.x, p_size.z) * 0.5
	var xy = Vector2(p_size.x, p_size.y) * 0.5
	var zy = Vector2(p_size.z, p_size.y) * 0.5
	var uvcoords = PoolVector2Array()
	# Top face
	uvcoords.push_back(Vector2(0.0, 0.0) * xz)
	uvcoords.push_back(Vector2(1.0, 0.0) * xz)
	uvcoords.push_back(Vector2(1.0, 1.0) * xz)
	uvcoords.push_back(Vector2(0.0, 1.0) * xz)
	# Bottom face
	uvcoords.push_back(Vector2(0.0, 0.0) * xz)
	uvcoords.push_back(Vector2(1.0, 0.0) * xz)
	uvcoords.push_back(Vector2(1.0, 1.0) * xz)
	uvcoords.push_back(Vector2(0.0, 1.0) * xz)
	# Front face
	uvcoords.push_back(Vector2(0.0, 0.0) * xy)
	uvcoords.push_back(Vector2(1.0, 0.0) * xy)
	uvcoords.push_back(Vector2(1.0, 1.0) * xy)
	uvcoords.push_back(Vector2(0.0, 1.0) * xy)
	# Back face
	uvcoords.push_back(Vector2(0.0, 0.0) * xy)
	uvcoords.push_back(Vector2(1.0, 0.0) * xy)
	uvcoords.push_back(Vector2(1.0, 1.0) * xy)
	uvcoords.push_back(Vector2(0.0, 1.0) * xy)
	# Right side face
	uvcoords.push_back(Vector2(0.0, 0.0) * zy)
	uvcoords.push_back(Vector2(1.0, 0.0) * zy)
	uvcoords.push_back(Vector2(1.0, 1.0) * zy)
	uvcoords.push_back(Vector2(0.0, 1.0) * zy)
	# Left side face
	uvcoords.push_back(Vector2(0.0, 0.0) * zy)
	uvcoords.push_back(Vector2(1.0, 0.0) * zy)
	uvcoords.push_back(Vector2(1.0, 1.0) * zy)
	uvcoords.push_back(Vector2(0.0, 1.0) * zy)
	return uvcoords

func _generate_brick_mesh_uv2() -> PoolVector2Array:
	var uvcoords = PoolVector2Array()
	for face in range(6):
		uvcoords.push_back(Vector2(0.0, 0.0))
		uvcoords.push_back(Vector2(1.0, 0.0))
		uvcoords.push_back(Vector2(1.0, 1.0))
		uvcoords.push_back(Vector2(0.0, 1.0))
	return uvcoords

func _generate_brick_mesh_indices() -> PoolIntArray:
	var indices = PoolIntArray()
	for face in range(6):
		var istart = face * 4
		indices.push_back(istart + 0)
		indices.push_back(istart + 1)
		indices.push_back(istart + 3)
		indices.push_back(istart + 3)
		indices.push_back(istart + 1)
		indices.push_back(istart + 2)
	return indices
