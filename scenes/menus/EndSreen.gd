extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_MenuButton_pressed() -> void:
	get_tree().change_scene("res://scenes/menus/MainMenu.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
