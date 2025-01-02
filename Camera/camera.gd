extends Node3D

var camera_speed:float = 20.0;

var camera_zoom_min:float = 10.0;
var camera_zoom_max:float = 25.0;

var camera_zoom_speed:float = 30.0;

var camera_zoom_speed_damp:float = 0.92;

var camera_zoom_direction:float;

@onready var camera:Camera3D = $CameraSocket/Camera3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_base_move(delta);
	camera_zoom(delta);
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ZoomIn"):
		camera_zoom_direction = -1;
	if event.is_action("ZoomOut"):
		camera_zoom_direction = 1;
	
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
		
	position += VelocityDirection.normalized() * delta * camera_speed
	
func camera_zoom(delta:float)->void:
	var new_zoom:float = clamp(camera.position.z + camera_zoom_speed * camera_zoom_direction * delta, camera_zoom_min, camera_zoom_max);
	camera.position.z = new_zoom
	camera_zoom_direction *= camera_zoom_speed_damp
