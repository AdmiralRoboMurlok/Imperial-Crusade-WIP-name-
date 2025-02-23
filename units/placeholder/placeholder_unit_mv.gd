extends Node3D

enum ALIGNMENT { PLAYER, ALLY, NEUTRAL, ENEMY}
@export var my_alignment: ALIGNMENT;

const SPEED = 5.0;
var Selectable = true;
@export var Selected:bool = false;
@export_range(1, 12, 1) var Team:int = 1;

var MoveTarget = Vector3.ZERO;
var Velocity = Vector3.ZERO;

func set_selected(selected: bool):
	Selected = selected
	$Sprite3D.visible = selected

func _input(event: InputEvent) -> void: #This works like trash I hate this  
	if Input.is_action_just_pressed("Move"):
		var SpaceState = get_world_3d().direct_space_state
		var Cam = get_viewport().get_camera_3d()
		var MousePos = get_viewport().get_mouse_position()
		
		var origin = Cam.project_ray_origin(MousePos)
		var end = origin + Cam.project_ray_normal(MousePos) * 100
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		
		var result = SpaceState.intersect_ray(query)
		
		if result.has("position"):
				MoveTarget = result["position"]

func _physics_process(delta: float) -> void:
	if MoveTarget != Vector3.ZERO and Selected == true:
		var direction = (MoveTarget - global_transform.origin).normalized()
		Velocity = direction * SPEED
		
		global_translate(Velocity * delta)
		
		if global_transform.origin.distance_to(MoveTarget) < 0.1:
			MoveTarget = Vector3.ZERO
			Velocity = Vector3.ZERO

func _ready():
	$Sprite3D.visible = false
	add_to_group("Units")
