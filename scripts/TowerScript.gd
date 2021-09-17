extends Spatial


onready var ball = $Ball
onready var tower_mesh = $delivery_tower_model
onready var ground_ray = $delivery_tower_model/RayCast

#mesh ref
onready var icosphere = $delivery_tower_model/Icosphere
onready var pipes = $delivery_tower_model/pipe_cross002

export var jump_impulse:= 500
export var sphere_offset: = Vector3(0, -1.4, 0)
export var acceleration:= 50
export var steering:= 21.0
export var turn_speed:= 5
export var turn_stop_limit:= 0.75
export var body_tilt:= 35.0
export var animation_magic_number:= 8

var _speed_input:= 0.0
var _rotate_input:= 0.0

var _grounded:= false
var _jumping:= false

var _frozen:=  false
var _saved_av := Vector3.ZERO
var _saved_lv := Vector3.ZERO


func _ready() -> void:
	ground_ray.add_exception(ball)
	
func _physics_process(_delta: float) -> void:
	if not _frozen:
		tower_mesh.transform.origin = ball.transform.origin + sphere_offset
		ball.add_central_force(-tower_mesh.global_transform.basis.z * _speed_input)
		if _jumping:
			ball.add_central_force(tower_mesh.global_transform.basis.y * jump_impulse)
			_jumping = false
	
func _process(delta: float) -> void:
	#set_process(true)
	if ground_ray.is_colliding():
		_grounded = true
	else:
		_grounded = false
		
	#finding a way to 'freeze-frame' mid air at end	
	if Input.is_action_pressed("ui_focus_next"):
		if _frozen:
			unfreeze()
		else:
			freeze_frame()
	
	#get input
	if not _frozen:
		if Input.is_action_pressed("reset"):
			death()
		_handle_movement()
	
	#flavor mesh animations...
	icosphere.rotation = ball.rotation * animation_magic_number
	pipes.rotation.y += ball.linear_velocity.length() / animation_magic_number  * delta 

	#move mesh to ball, apply rotating on turning
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = tower_mesh.global_transform.basis.rotated(
			tower_mesh.global_transform.basis.y,
			 _rotate_input)
		tower_mesh.global_transform.basis = tower_mesh.global_transform.basis.slerp(
			new_basis,
			turn_speed * delta)
		tower_mesh.global_transform = tower_mesh.global_transform.orthonormalized()
		
		#tilt body for effect
		var t = - _rotate_input * ball.linear_velocity.length() / body_tilt
		tower_mesh.rotation.z = lerp(tower_mesh.rotation.z, t, animation_magic_number * delta)
	
	#aligh mesh with ground
	var n = ground_ray.get_collision_normal()
	var xform = _align_with_y(tower_mesh.global_transform, n.normalized())
	tower_mesh.global_transform = tower_mesh.global_transform.interpolate_with(xform, 10 * delta)

func _handle_movement() -> void:
	_speed_input = 0.0
	_speed_input += Input.get_action_strength("accelerate")
	_speed_input -= Input.get_action_strength("brake")
	_speed_input *= acceleration
	
	if _grounded and Input.is_action_pressed("jump"):
		_jumping = true
	

	_rotate_input = 0.0
	_rotate_input += Input.get_action_strength("steer_left")
	_rotate_input -= Input.get_action_strength("steer_right")
	_rotate_input *= deg2rad(steering)
	
func _align_with_y(xform: Transform, new_y: Vector3) -> Transform:
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
	
func freeze_frame() -> void:
	_frozen = true
	_saved_av = ball.angular_velocity
	_saved_lv = ball.linear_velocity
	ball.set_angular_velocity(Vector3.ZERO)
	ball.set_linear_velocity(Vector3.ZERO)
	ball.set_sleeping(true)

func unfreeze() -> void:
	_frozen = false
	ball.set_sleeping(false)
	ball.set_angular_velocity(_saved_av)
	ball.set_linear_velocity(_saved_lv)
	
	
func death() -> void:
	get_parent().send_message("Player is dead", 1.0)
	get_tree().reload_current_scene()
	
func get_speed():
	return ball.linear_velocity.length()


func _on_Ball_body_entered(body: Node) -> void:
	print("ball asks who: ",body.get_name())
