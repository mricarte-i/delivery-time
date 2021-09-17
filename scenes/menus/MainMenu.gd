extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var play = $VBoxContainer/VBoxContainer/Play

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.grab_focus()
	Checkpoint.clean_up()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Play_pressed() -> void:
	get_tree().change_scene("res://scenes/TestLevel.tscn")


func _on_Settings_pressed() -> void:
	OS.set_window_fullscreen(!OS.is_window_fullscreen())


func _on_Exit_pressed() -> void:
	get_tree().quit()
