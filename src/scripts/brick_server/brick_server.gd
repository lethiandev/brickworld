extends Node
tool

const BrickMeshGenerator = preload("./generators/brick_mesh_generator.gd")
const BrickShapeGenerator = preload("./generators/brick_shape_generator.gd")

var mesh_generator: BrickMeshGenerator = BrickMeshGenerator.new()
var shape_generator: BrickShapeGenerator = BrickShapeGenerator.new()

# Returns brick mesh for rendering
func get_brick_mesh(p_size: Vector3) -> Mesh:
	var resource = mesh_generator.get_brick_resource(p_size) 
	return resource as Mesh

# Returns brick collision shape
func get_brick_shape(p_size: Vector3) -> Shape:
	var resource = shape_generator.get_brick_resource(p_size)
	return resource as Shape
