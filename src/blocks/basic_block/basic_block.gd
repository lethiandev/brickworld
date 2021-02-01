extends StaticBody
tool

export(Vector3) var block_size: Vector3 = Vector3(2.0, 3.0, 4.0) \
	setget set_block_size, get_block_size
export(Material) var block_material: Material = null \
	setget set_block_material, get_block_material

func _ready() -> void:
	set_block_size(block_size)
	set_block_material(block_material)

func set_block_size(p_size: Vector3) -> void:
	block_size = p_size
	if has_node("MeshInstance"):
		$CollisionShape.set_block_size(p_size)
		$MeshInstance.set_block_size(p_size)

func get_block_size() -> Vector3:
	return block_size

func set_block_material(p_material: Material) -> void:
	block_material = p_material
	if has_node("MeshInstance"):
		$MeshInstance.material_override = p_material

func get_block_material() -> Material:
	return block_material
