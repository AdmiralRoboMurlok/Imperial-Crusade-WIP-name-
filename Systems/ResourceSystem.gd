extends Node
class_name ResourceSystem

enum ResourceType {
	Mine #Add second resouce
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("resources")
	#collision_layer = 0b00000000_00000000_00000000_00001000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
