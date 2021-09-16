tool
extends TextureButton

onready var label = $RichTextLabel
onready var left = $left_img
onready var right = $right_img

export(String) var text = "Text Button"
export(int) var arrow_margin_from_center = 100


func _ready():
	_setup_text()
	_hide_imgs()
	set_focus_mode(true)

func _process(_delta: float) -> void:
	if Engine.editor_hint:
		_setup_text()
		_show_imgs()
		

func _setup_text():
	label.bbcode_text = "[center] %s [/center]" % [text]
	
func _show_imgs():
	for img in [left, right]:
		img.visible = true
		img.global_position.y = rect_global_position.y + (rect_size.y / 3.0)
	
	var center_x = rect_global_position.x + (rect_size.x / 2)
	left.global_position.x = center_x - arrow_margin_from_center
	right.global_position.x = center_x + arrow_margin_from_center
	
func _hide_imgs():
	for img in [left, right]:
		img.visible = false


func _on_TextureButton_focus_entered() -> void:
	_show_imgs()


func _on_TextureButton_focus_exited() -> void:
	_hide_imgs()


func _on_TextureButton_mouse_entered() -> void:
	grab_focus()
