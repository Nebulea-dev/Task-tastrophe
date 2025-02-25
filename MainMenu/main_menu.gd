extends MarginContainer

const level_selection_scene = preload("res://MainMenu/LevelSelector.tscn")
const level_1_scene = preload("res://levels/Level1.tscn")

@onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
@onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector

var current_selection = 0
const MAX_SELECTION = 2

func _ready() -> void:
	set_current_selection(current_selection)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("player1_down") or Input.is_action_just_pressed("player2_down"):
		current_selection += 1
		if current_selection == MAX_SELECTION:
			current_selection = 0
			
		set_current_selection(current_selection)
		
	if Input.is_action_just_pressed("player1_up") or Input.is_action_just_pressed("player2_up"):
		current_selection -= 1
		if current_selection < 0:
			current_selection = MAX_SELECTION - 1
			
		set_current_selection(current_selection)
		
	if Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	
	if _current_selection == 0:
		selector_one.text = "> "
	if _current_selection == 1:
		selector_two.text = "> "

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(level_selection_scene.instantiate())
		queue_free()
		
	if _current_selection == 1:
		await SceneTransition.close_circle()
		get_tree().quit()
