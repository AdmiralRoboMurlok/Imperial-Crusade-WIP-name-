extends Node3D

var SelectedUnits:Array = [];
@onready var camera = $Camera;

func _input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_action_pressed("Select"):
		if event.button_index == MOUSE_BUTTON_LEFT:
			SelectUnit(event.position);
			
func SelectUnit(mouse_pos):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
