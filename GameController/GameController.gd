extends Node2D

var DraggingSelectionBox = false
var SelectionRect = Rect2()

const MinimalDrag: int = 128

@onready var camera:Node3D = $Camera
@onready var visibleunits:Area3D = $Camera/VisibleUnitsArea3D
@onready var box:NinePatchRect = $SelectionBox

@onready var VisableUnits:Dictionary = {}

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Select"):
		SelectionRect.position = get_global_mouse_position()
		box.position = SelectionRect.position
		DraggingSelectionBox = true
	if Input.is_action_just_released("Select"):
		DraggingSelectionBox = false
		box.visible = false
		SelectionBoxLogic()
		
func SelectionBoxLogic() -> void: # Selection logic doesn't work we need to fix it -G
	for unit in VisableUnits.values():
		if SelectionRect.abs().has_point(camera.Vector3ToVector2(unit.transform.origin)) and unit.is_in_group("units"):
			unit.set_selected(true)
		elif unit.is_in_group("units"): # There is an error here -G
			unit.set_selected(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_ui()

func unit_visible(unit:Node3D) -> void:
	var unit_id:int = unit.get_instance_id()
	if VisableUnits.keys().has(unit_id):
		return
	VisableUnits[unit_id] = unit.get_parent()
	debug_unit_visible()
	
func unit_not_visible(unit:Node3D) -> void:
	var unit_id:int = unit.get_instance_id()
	if !VisableUnits.keys().has(unit_id):
		return
	VisableUnits.erase(unit_id)
	debug_unit_visible()

func init_ui() -> void:
	box.visible = false
	visibleunits.body_entered.connect(unit_visible)
	visibleunits.body_exited.connect(unit_not_visible)

func _process(delta: float) -> void:
	if DraggingSelectionBox:
		SelectionRect.size = get_global_mouse_position() - SelectionRect.position
		UpdateDragbox()
		
		if !box.visible:
			if SelectionRect.size.length_squared() > MinimalDrag:
				box.visible = true
			
		SelectionRect.size = get_global_mouse_position() - SelectionRect.position
	
func UpdateDragbox() -> void:
	box.size = abs(SelectionRect.size)
	#Pozwala na odwracanie SelectBoxa
	if SelectionRect.size.x < 0:
		box.scale.x = -1
	else:
		box.scale.x = 1
	if SelectionRect.size.y < 0:
		box.scale.y = -1
	else:
		box.scale.y = 1

func debug_unit_visible() -> void:
	print(VisableUnits)
