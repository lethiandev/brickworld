extends Control

func _ready():
	add_exception(get_node("../.."))

func _physics_process(p_delta: float) -> void:
	var sprite = $CursorAnchor/CursorSprite as Sprite
	var distance = _get_collider_length()
	var length = cast_to.length()
	var scaled = clamp(length - distance, 0.25, 1.0)
	sprite.scale = Vector2(scaled, scaled)

func _get_collider_length() -> float:
	var point = get_collision_point()
	var local = global_transform.origin
	return local.distance_to(point)
