extends Node3D
class_name UnitBase

# Enum for different team alignments
enum ALIGNMENT { PLAYER, ALLY, NEUTRAL, ENEMY }
@export var my_alignment: ALIGNMENT

# Basic unit properties
const SPEED = 5.0
var Selectable = true
var Movable = true
@onready var nav = get_parent()
@export var Selected: bool = false
@export_range(1, 12, 1) var Team: int = 1

# Inventory system (Dictionary)
var inventory: Dictionary = {}

func _ready():
	$Sprite3D.visible = false  # Hide selection marker initially
	add_to_group("units")  # Add unit to "Units" group

# Function to handle unit selection
var MoveTarget = Vector3.ZERO;
var Velocity = Vector3.ZERO;

func set_selected(selected: bool):
	Selected = selected
	$Sprite3D.visible = selected  # Show selection marker if selected

var current_agent_path = []
var current_agent_path_index = 0

func _physics_process(delta: float) -> void:
#	if MoveTarget != Vector3.ZERO and Selected == true:
#		move(delta)
	if Input.is_action_just_pressed("Move") and Selected == true and Movable == true:
		var mouse_pos = RaycastSystem.get_mouse_world_position()
		var from_pos = self.global_position
		var to_pos = mouse_pos if mouse_pos else self.global_position
		var path = NavigationSystem.get_shortest_path(from_pos, to_pos)
		
		if not path.is_empty():
			current_agent_path = path
			current_agent_path_index = 0
	
	if current_agent_path.size() > 0 and current_agent_path_index < current_agent_path.size():
		var target_pos = current_agent_path[current_agent_path_index]
		var direction = (target_pos - self.global_position).normalized()
		var distance = self.global_position.distance_to(target_pos)
		
		self.look_at(target_pos)
		self.global_position += direction * min(distance, delta * 32)
		
		if distance < 0.5:
			current_agent_path_index = 1

	if current_agent_path_index >= current_agent_path.size():
		current_agent_path.clear()
			
	#if current_agent_path.is_empty():
		#velocity = Vector3(0, 0, 0)

# Function to detect when the unit is clicked
func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		set_selected(true)  # Select this unit when clicked
