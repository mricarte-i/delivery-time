extends Control


onready var timeLabel = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func show_result(condition):
	self.visible = true
	var time = Checkpoint.get_time()
	timeLabel.text = time
	if condition:
		$VBoxContainer/CenterContainer/great_text.visible = true
		$VBoxContainer/CenterContainer/bad_text.visible = false
	else:
		$VBoxContainer/CenterContainer/great_text.visible = false
		$VBoxContainer/CenterContainer/bad_text.visible = true
	#timeLabel.bbcode_text = "[wave amp=50 freq=5][center] %s [/center][/wave]" % time

func hide() -> void:
	self.visible = false


func _on_RetryButton_pressed() -> void:
	Checkpoint.clean_up()
	get_tree().reload_current_scene()


func _on_NextButton_pressed() -> void:
	Checkpoint.clean_up()
	get_tree().next_level()


func _on_ExitButton_pressed() -> void:
	Checkpoint.clean_up()
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")
