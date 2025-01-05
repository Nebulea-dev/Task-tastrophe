extends Control

const main_menu_scene = preload("res://MainMenu/main_menu.tscn")

@onready var blackRect = $CanvasLayer/ColorRect
@onready var animation = $CanvasLayer/ColorRect/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackRect.material.set_shader_parameter("circle_size", 1.05)
	blackRect.material.set_shader_parameter("screen_width", blackRect.size.x)
	blackRect.material.set_shader_parameter("screen_height", blackRect.size.y)

func close_circle() -> void:
	animation.play("close")
	await animation.animation_finished
	
func open_circle() -> void:
	animation.play("open")
	await animation.animation_finished
