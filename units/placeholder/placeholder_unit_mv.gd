extends Node3D

enum ALIGNMENT { PLAYER, ALLY, NEUTRAL, ENEMY}
@export var my_alignment: ALIGNMENT

const SPEED = 5.0;
var Selectable = true;
@export var Selected:bool = false;
@export_range(1, 12, 1) var Team:int = 1;

func set_selected(selected: bool):
	Selected = selected
	$Sprite3D.visible = selected



func _ready():
	$Sprite3D.visible = false
	add_to_group("Units")
