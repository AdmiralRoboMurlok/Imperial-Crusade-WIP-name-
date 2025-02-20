extends Node3D

@export_range(0, 100, 1) var camera_speed:float = 20.0;

@export_range(0, 100, 1) var camera_zoom_min:float = 10.0;
@export_range(0, 100, 1) var camera_zoom_max:float = 25.0;

@export_range(0, 100, 1) var camera_zoom_speed:float = 30.0;
@export_range(0, 2, 0.1) var camera_zoom_speed_damp:float = 0.92;

var camera_zoom_direction:float;

#wszystko z pan jest nieużywane
@export_range(0, 32, 4) var camera_automatic_pan_margin:int = 16;
@export_range(0, 20, 0.5) var camera_automatic_pan_speed:float = 12;

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

func camera_automatic_pan(delta:float)-> void:
	var viewport_current:Viewport = get_viewport();
	#[PL] to można kiedyś dokończyć, by gdy myszka zbliża się do krańcy ekranu to kamera się rusza jak, przy WASD
	#wiem, że nie do końca po polsku, ale no 
	#[ENG] this can be finished but it's not a priority for now. What it would do is when you 
	#bring your mouse to the border of the screen the camera would move like with WASD
