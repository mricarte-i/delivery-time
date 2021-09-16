extends Control


onready var timeLabel = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func show() -> void:
	self.visible = true
	var time = Checkpoint.get_time()
	timeLabel.text = time
	#timeLabel.bbcode_text = "[wave amp=50 freq=5][center] %s [/center][/wave]" % time

func hide() -> void:
	self.visible = false
