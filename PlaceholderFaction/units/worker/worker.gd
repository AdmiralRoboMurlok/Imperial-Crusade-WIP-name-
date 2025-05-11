extends UnitBase

@export var CarryingCrystal: bool = false
var CrystalMiningState: bool = false 

func StateCarryingCrystal(Carrying: bool) -> void:
	CarryingCrystal = Carrying
	# Ustawić alternatywny model noszący na widoczny
	
func HarvestingCrystal() -> void: # Trzeba dodać opcje by mógł przestać minować
	Movable = false
	await get_tree().create_timer(3.0).timeout # To jest najbardziej problematyczne trzeba będzie to potem zmienić
	StateCarryingCrystal(true)
	Movable = true
	#Trzeba dać funkcję, żeby crystal tracił

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D.visible = false  
	add_to_group("units")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
