extends RayCast

var plane: Plane = Plane()
var offset: Vector3 = Vector3()

const BRICK_SIZE = Vector3(4, 4, 2)

func _ready():
	$BrickPreview.mesh = BrickServer.get_brick_mesh(BRICK_SIZE)
	add_exception(get_node("../.."))

func _process(p_delta: float) -> void:
	if is_colliding() and not Input.is_key_pressed(KEY_CONTROL):
		_update_plane()
	_update_preview()
	if Input.is_action_just_pressed("action"):
		_place_brick()

func _update_plane() -> void:
	var n = get_collision_normal()
	var p = get_collision_point()
	plane.normal = n
	offset = p

func _update_preview() -> void:
	var n = plane.normal
	var p = offset
	
	var from = global_transform.origin - p
	var dir = -global_transform.basis.z
	var coll = plane.intersects_ray(from, dir)
	
	if coll != null and not n.is_equal_approx(Vector3.ZERO):
		var brick_factor = SharedConstants.BRICK_BASE * SharedConstants.BRICK_SCALE
		var pos = ((coll + p + brick_factor * 0.5) / brick_factor).floor() * brick_factor
		$MeshInstance.global_transform.origin = pos + n * 0.002
		$MeshInstance.global_transform.basis = Transform().looking_at(n, Vector3.FORWARD).basis
		
		var brick_hsize = BRICK_SIZE * brick_factor * 0.5
		$BrickPreview.global_transform.origin = pos -  brick_hsize + n * brick_hsize
		$BrickPreview.global_transform.basis = Basis()

func _place_brick() -> void:
	var space = get_world().direct_space_state
	var query = PhysicsShapeQueryParameters.new()
	query.shape_rid = BrickServer.get_brick_shape(BRICK_SIZE).get_rid()
	query.transform = $BrickPreview.global_transform
	query.margin = -0.001
	
	var colls = space.intersect_shape(query)
	if colls and not colls.empty():
		print("Cannot place element!")
	else:
		var brick_scene = preload("res://bricks/brick_classic/brick_classic.tscn")
		var brick = brick_scene.instance()
		brick.brick_size = BRICK_SIZE
		get_node("../../../World").add_child(brick)
		brick.global_transform = $BrickPreview.global_transform
