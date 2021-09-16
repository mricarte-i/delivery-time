extends Area


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_EndgoalArea_body_entered(body: Node) -> void:
	if(body.get_name() == 'Ball'):
		body.get_parent().get_parent().send_message("FINISHED", 5.0)
		Checkpoint.finished = true
		print('FINISHED: ', Checkpoint.finished)
