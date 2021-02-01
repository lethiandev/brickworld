extends Node
tool

const BLOCK_SIZE = Vector3(1.0, 0.5, 1.0) / 8.0

const MeshBlockGenerator = preload("./mesh_block_generator.gd")
const ShapeBlockGenerator = preload("./shape_block_generator.gd")

var mesh_cache: Dictionary = Dictionary()
var shape_cache: Dictionary = Dictionary()

var mesh_generator: MeshBlockGenerator
var shape_generator: ShapeBlockGenerator

func _init():
	mesh_generator = MeshBlockGenerator.new()
	mesh_generator.block_scale = BLOCK_SIZE
	
	shape_generator = ShapeBlockGenerator.new()
	shape_generator.block_scale = BLOCK_SIZE

func get_block_mesh(p_size: Vector3) -> ArrayMesh:
	if mesh_cache.has(p_size):
		return mesh_cache[p_size]
	return _create_block_mesh(p_size)

func get_block_shape(p_size: Vector3) -> Shape:
	if shape_cache.has(p_size):
		return shape_cache[p_size]
	return _create_block_shape(p_size)

func _create_block_mesh(p_size: Vector3) -> ArrayMesh:
	var mesh = mesh_generator.create_block_mesh(p_size)
	mesh_cache[p_size] = mesh
	return mesh

func _create_block_shape(p_size: Vector3) -> Shape:
	var shape = shape_generator.create_block_shape(p_size)
	shape_cache[p_size] = shape
	return shape
