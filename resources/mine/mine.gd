extends Node3D

@export var value: int = 3600;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("resources")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value <= 0:
		deplete()

func deplete() -> void:
	queue_free()
