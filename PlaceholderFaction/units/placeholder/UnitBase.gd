extends Node3D
class_name UnitBase

# Signal emitted when a unit is selected (for UI updates)
signal unit_selected(unit)

# Enum for different team alignments
enum ALIGNMENT { PLAYER, ALLY, NEUTRAL, ENEMY }
@export var my_alignment: ALIGNMENT

# Basic unit properties
const SPEED = 5.0
var Selectable = true
@onready var nav = get_parent()
@export var Selected: bool = false
@export_range(1, 12, 1) var Team: int = 1

# Inventory system (Dictionary)
var inventory: Dictionary = {}

func _ready():
	$Sprite3D.visible = false  # Hide selection marker initially
	add_to_group("Units")  # Add unit to "Units" group


# Function to handle unit selection
var MoveTarget = Vector3.ZERO;
var Velocity = Vector3.ZERO;

func set_selected(selected: bool):
	Selected = selected
	$Sprite3D.visible = selected  # Show selection marker if selected
	if selected:
		unit_selected.emit(self)  # Notify UI to update inventory display

func _input(event: InputEvent) -> void: # This works like trash I hate this  
	# Update: This works even worse now, fuck this shit -G
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
			# Perform a downward raycast to find the floor - Gerard
			var ground_query = PhysicsRayQueryParameters3D.create(
				result["position"] + Vector3(0, 1, 0), 
				result["position"] + Vector3(0, -10, 0)
			)
			var ground_result = SpaceState.intersect_ray(ground_query)

			if ground_result.has("position"):
				MoveTarget = ground_result["position"]  # Ensure target is on the floor - Gerard

func _physics_process(delta: float) -> void:
	if MoveTarget != Vector3.ZERO and Selected == true:
		var direction = (MoveTarget - global_transform.origin).normalized()
		Velocity = direction * SPEED
		
		global_translate(Velocity * delta)
		
		var space_state = get_world_3d().direct_space_state
		var ground_check = PhysicsRayQueryParameters3D.create(
			global_transform.origin + Vector3(0, 1, 0),
			global_transform.origin + Vector3(0, -10, 0)
		)
		var ground_result = space_state.intersect_ray(ground_check)
		
		if ground_result.has("position"):
			global_transform.origin.y = ground_result["position"].y
		
		if global_transform.origin.distance_to(MoveTarget) < 0.1:
			MoveTarget = Vector3.ZERO
			Velocity = Vector3.ZERO

# Function to detect when the unit is clicked
func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		set_selected(true)  # Select this unit when clicked
