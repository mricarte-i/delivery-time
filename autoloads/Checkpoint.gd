extends Node

var level_started = false
var time = 0

var last_position = null
var finished = false

var seen_before = []

func register_level_started() -> void:
	level_started = true

func register_level_end() -> void:
	level_started = false
	
func _process(delta: float) -> void:
	if level_started:
		time += delta
	

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
	level_started = false
	time = 0
	
func get_time() -> String:
	var mils = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60*60) /60
	var time_passed = "%02d:%02d.%03d" % [mins, secs, mils]
	return time_passed
	
func condition() -> bool:
	if time <= 120.0:
		return true
	return false
