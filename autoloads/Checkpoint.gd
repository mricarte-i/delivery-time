extends Node

var last_position = null
var finished = false

var seen_before = []

func register_checkpoint(name: String, pos: Vector3) -> bool:
	if _check_if_repeated_name(name):
		return false
	
	seen_before.append(name)
	last_position = pos
	return true

func _check_if_repeated_name(name: String) -> bool:
	for i in range(0, seen_before.size()):
		if name == seen_before[i]:
			return true
	
	return false

func clean_up() -> void:
	seen_before.clear()
	last_position = null
	finished = false
