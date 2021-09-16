tool
extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player = $Tower
onready var playerRB = $Tower/Ball
onready var ui = $Control
onready var endscreen = $FinishScreenMenu


export(PackedScene) var nextscene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Checkpoint.level_started:
		Checkpoint.register_level_started()
	
	if Checkpoint.last_position:
		$Tower.translation = Checkpoint.last_position
	

func _process(_delta: float) -> void:
	endscreen.show()
	
func _on_KillArea_body_entered(body: Node) -> void:
	#print('WHO IS THIS ', body.get_name())
	if body.get_name() == playerRB.get_name():
		print('it me')
	#the player's actual rigidbody is called 'Ball' !
	#if body.get_name() == player.get_name():
	#	print('THE PLAYER HAS FALLEN INTO THE VOID')
	
func send_message(msg: String, time: float) -> void:
	if msg == "FINISHED":
		Checkpoint.register_level_end()
		player.freeze_frame()
		endscreen.show()
		
	ui.show_message(msg, time)
