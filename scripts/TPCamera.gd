extends Camera

export(float) var lerp_speed = 3.0
export(NodePath) var target_path = null
export(Vector3) var offset = Vector3.ZERO

var _target = null

func _ready() -> void:
	if target_path:
		_target = get_node(target_path)
		
func _physics_process(delta: float) -> void:
	if !_target:
		return
	
	var target_pos = _target.global_transform.translated(offset)
	global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
	look_at(_target.global_transform.origin, Vector3.UP)
