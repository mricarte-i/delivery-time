extends CanvasLayer

onready var bg = $Background

func _ready():
	_set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("PAUSE?")
		_set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused

func _set_visible(is_visible: bool) -> void:
	for node in get_children():
		node.visible = is_visible


func _on_ExitButton_pressed() -> void:
	_set_visible(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")


func _on_RestartButton_pressed() -> void:
	_set_visible(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	Checkpoint.clean_up()
	get_tree().reload_current_scene()


func _on_PauseButton_pressed() -> void:
	get_tree().paused = false
	_set_visible(false)
