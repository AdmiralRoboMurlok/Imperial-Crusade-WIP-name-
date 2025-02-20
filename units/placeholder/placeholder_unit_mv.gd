extends Node3D

# Signal emitted when a unit is selected (for UI updates)
signal unit_selected(unit)

# Enum for different team alignments
enum ALIGNMENT { PLAYER, ALLY, NEUTRAL, ENEMY }
@export var my_alignment: ALIGNMENT

# Basic unit properties
const SPEED = 5.0
var Selectable = true
@export var Selected: bool = false
@export_range(1, 12, 1) var Team: int = 1

# Inventory system (Dictionary)
var inventory: Dictionary = {}

func _ready():
	$Sprite3D.visible = false  # Hide selection marker initially
	add_to_group("Units")  # Add unit to "Units" group
	add_item("Crystal", 3)  # Example: Each unit starts with 3 Crystals

# Function to handle unit selection
func set_selected(selected: bool):
	Selected = selected
	$Sprite3D.visible = selected  # Show selection marker if selected
	if selected:
		unit_selected.emit(self)  # Notify UI to update inventory display

# Function to add items to inventory
func add_item(item_name: String, amount: int):
	if item_name in inventory:
		inventory[item_name] += amount
	else:
		inventory[item_name] = amount

# Function to remove items from inventory
func remove_item(item_name: String, amount: int):
	if item_name in inventory:
		inventory[item_name] -= amount
		if inventory[item_name] <= 0:
			inventory.erase(item_name)  # Remove item if amount reaches 0

# Function to transfer items between units
func transfer_item(target_unit: Node3D, item_name: String, amount: int):
	if item_name in inventory and inventory[item_name] >= amount:
		remove_item(item_name, amount)  # Deduct from current unit
		target_unit.add_item(item_name, amount)  # Add to target unit
		print("Transferred %d %s to %s" % [amount, item_name, target_unit.name])
	else:
		print("Not enough %s to transfer!" % item_name)

# Function to detect when the unit is clicked
func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		set_selected(true)  # Select this unit when clicked
