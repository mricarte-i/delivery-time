extends Control

onready var valtext = $valuesLabel
onready var keytext = $keyLabel
onready var msgtext = $messageLabel
onready var timer = $Timer

var acc := 0.0
var rot := 0.0
var br := 0.0

var _timed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keytext.clear()
	valtext.clear()
	msgtext.clear()
	pass # Replace with function body.


func _process(_delta: float) -> void:
	acc = Input.get_action_strength("accelerate")
	rot = Input.get_action_strength("rotate")
	br = Input.get_action_strength("brake")
	
	valtext.text = str("Accelerate: ", acc, "\n", "Rotate: ", rot, "\n", "Brake: ", br, "\n")
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		keytext.text = str("key: ", OS.get_scancode_string(event.scancode))

func show_message(msg: String, time: float) -> void:
	if(timer.time_left):
		timer.stop()
		
	msgtext.text = msg
	timer.set_wait_time(time)
	timer.set_one_shot(true)
	timer.start()
	


func _on_Timer_timeout() -> void:
	msgtext.clear()
