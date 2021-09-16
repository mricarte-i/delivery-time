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


func _on_Area_body_entered(body: Node) -> void:
	if(body.get_name() == 'Ball'):
		var res = Checkpoint.register_checkpoint(self.get_name(), self.translation)
		if res:
			body.get_parent().get_parent().send_message("CHECKPOINT", 2.0)
			print('CHECKPOINT: ', Checkpoint.last_position)
		else:
			print('REPEATED CHECKPOINT, NO UI MESSAGE')			
