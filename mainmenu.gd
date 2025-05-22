
class_name Mainmenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Button2

@export var start_level: PackedScene = preload("res://Camera/camera.tscn")

func _ready() -> void:
	start_button.pressed.connect(on_start_pressed)
	exit_button.pressed.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
