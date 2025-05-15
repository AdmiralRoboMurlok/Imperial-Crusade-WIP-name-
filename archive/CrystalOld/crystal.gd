extends Node3D

@export var CrystalStorage: int = 320 # This number may change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CrystalStorage == 0: # Jeśli CrystalStorage osiąga zero usuwamy zasób
		queue_free()

func mined() -> void:
	CrystalStorage -= 20
