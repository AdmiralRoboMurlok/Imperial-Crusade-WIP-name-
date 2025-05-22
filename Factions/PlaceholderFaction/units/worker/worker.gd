extends UnitBase

enum StagesGathering{
	SEARCHING_RESOURCE = 200, GOING_TO_RESOURCE, GATHERING_RESOURCE, RETURNING_RESOURCE
}

@export var CarryingCrystal: bool = false
var CrystalMiningState: bool = false 

var currently_mining = null

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

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Move") and self in get_tree().get_nodes_in_group("units"):
		var target = RaycastSystem.get_raycast_hit_object(0b00000000_00000000_00000000_00001000)
		if target:
			if target in get_tree().get_nodes_in_group("resources"):
				currently_mining = target
				CrystalMiningState = true
		else:
			currently_mining = null
			CrystalMiningState = false
