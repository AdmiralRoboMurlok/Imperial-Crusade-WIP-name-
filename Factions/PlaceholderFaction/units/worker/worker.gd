extends UnitBase

@export var CarryingCrystal: bool = false
var CrystalMiningState: bool = false 

func StateCarryingCrystal(Carrying: bool) -> void:
	CarryingCrystal = Carrying
	# Ustawić alternatywny model noszący na widoczny
	
func Mining() -> void: # This function activates when you press right click on mine
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D.visible = false  
	add_to_group("units")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
