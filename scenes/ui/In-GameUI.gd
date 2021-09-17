tool
extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var timeLabel = $HBoxContainer/StopwatchLabel
onready var speedLabel = $HBoxContainer/SpeedLabel
onready var checkpointImg = $checkpoint_text
onready var timer = $Timer
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpointImg.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func update_ui(playerSpeed: float) -> void:
	timeLabel.bbcode_text = "\n [wave] %s [/wave]" % Checkpoint.get_time()
	speedLabel.bbcode_text = "\n [right][wave] %03d MPH [/wave][/right]" % playerSpeed
	
func checkpoint() -> void:
	if(timer.time_left):
		timer.stop()
		
	#checkpointImg.visible = true
	anim.play("checkpoint_anim")
	timer.set_wait_time(2)
	timer.set_one_shot(true)
	timer.start()


func _on_Timer_timeout() -> void:
	checkpointImg.visible = false
