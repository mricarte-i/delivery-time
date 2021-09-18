tool
extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player = $Tower
onready var playerRB = $Tower/Ball
onready var ui = $Control
onready var endscreen = $FinishScreenMenu
onready var ingameui = $UI


export(PackedScene) var nextscene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Checkpoint.level_started:
		Checkpoint.register_level_started()
	
	if Checkpoint.last_position:
		$Tower.translation = Checkpoint.last_position
	endscreen.hide()
	ingameui.visible = true

func _process(_delta: float) -> void:
	#endscreen.show()
	if player && !Engine.is_editor_hint():
		ingameui.update_ui(player.get_speed())
	
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
		endscreen.show_result(Checkpoint.condition())
		ingameui.visible = false
	else:
		ingameui.checkpoint()
	
	ui.show_message(msg, time)
	
func next_level() -> void:
	if nextscene:
		get_tree().change_scene_to(nextscene)
	else:
		print("oops")
