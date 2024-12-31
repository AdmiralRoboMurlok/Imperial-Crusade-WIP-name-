extends Node3D

var camera_speed:float = 20.0;

@onready var camera:Camera3D = $Camera3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_base_move(delta);
	
func camera_base_move(delta:float)-> void:
	var VelocityDirection:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("CameraForward"):
		VelocityDirection -= transform.basis.z;
	if Input.is_action_pressed("CameraBackward"):
		VelocityDirection += transform.basis.z;
	if Input.is_action_pressed("CameraWest"):
		VelocityDirection -= transform.basis.x;
	if Input.is_action_pressed("CameraEast"):
		VelocityDirection += transform.basis.x;
		
		#To chyba można użyć do scrolla jednak nie, ale mam pomysł jak to zrobić by się dało
	#if Input.is_action_pressed("CameraForward"):
	#	VelocityDirection -= transform.basis.z;
	#if Input.is_action_pressed("CameraBackward"):
	#	VelocityDirection += transform.basis.z;
		
	position += VelocityDirection.normalized() * delta * camera_speed;
	
