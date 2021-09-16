extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player = $Tower
onready var playerRB = $Tower/Ball
onready var ui = $Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Checkpoint.last_position:
		$Tower.translation = Checkpoint.last_position

func _enter_tree() -> void:
	pass # Replace with function body.

func _on_KillArea_body_entered(body: Node) -> void:
	#print('WHO IS THIS ', body.get_name())
	if body.get_name() == playerRB.get_name():
		print('it me')
	#the player's actual rigidbody is called 'Ball' !
	#if body.get_name() == player.get_name():
	#	print('THE PLAYER HAS FALLEN INTO THE VOID')
	
func send_message(msg: String, time: float) -> void:
	ui.show_message(msg, time)
