extends Node3D

var SelectedUnits:Array = [];
@onready var camera = $Camera/CameraSocket/Camera3D;

func _input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_action_pressed("Select"):
		if event.button_index == MOUSE_BUTTON_LEFT:
			SelectUnit(event.position);
			
func SelectUnit(mouse_pos: Vector2):
	var ray_orgin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	var space_state = get_world_3d().direct_space_state
	
	var query = PhysicsRayQueryParameters3D.create(ray_orgin, ray_direction)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	
	if result and result.collider.is_in_group("Units"):
		print("batman")
		clear_selection()
		result.collider.set_selected(true)
		SelectedUnits.append(result.collider)

func clear_selection():
	for unit in SelectedUnits:
		unit.set_selected(false)
	SelectedUnits.clear()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
