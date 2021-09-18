tool
extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(PackedScene) var next_scene
onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.set_speed_scale(0.5) 
	anim.play("op")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene_to(next_scene)


func _on_TextureButton_pressed() -> void:
	anim.stop()
	get_tree().change_scene_to(next_scene)
