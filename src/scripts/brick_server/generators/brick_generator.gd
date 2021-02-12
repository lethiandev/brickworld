extends Reference
tool

# Holds cached brick resources
var resource_cache: Dictionary

# Brick resource data generator
# Caches generated resource to optimize sequential calls
# Returns newly generated or already cached (and mutable!) brick resource
func get_brick_resource(p_size: Vector3) -> Resource:
	var cached = _get_cached_brick_resource(p_size)
	return cached if cached else _cache_brick_resource(p_size)

func _get_cached_brick_resource(p_size: Vector3) -> Resource:
	var has_cache = resource_cache.has(p_size)
	return resource_cache[p_size] if has_cache else null

func _cache_brick_resource(p_size: Vector3) -> Resource:
	var generated_resource = _generate_brick_resource(p_size)
	resource_cache[p_size] = generated_resource
	return generated_resource

# Method to override by derived script
# Returns generated brick resource (mutable!)
func _generate_brick_resource(p_size: Vector3) -> Resource:
	printerr("_generate_brick_resource must be overrided by derived scripts")
	return null
