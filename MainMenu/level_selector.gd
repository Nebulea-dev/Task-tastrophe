extends MarginContainer

@onready var selector_1 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect
@onready var selector_2 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect2
@onready var selector_3 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect3
@onready var selector_4 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect4
@onready var selector_5 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect5
@onready var selector_6 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/ReferenceRect
@onready var selector_7 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/ReferenceRect2
@onready var selector_8 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/ReferenceRect3
@onready var selector_9 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/ReferenceRect4
@onready var selector_10 = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/ReferenceRect5

@onready var player_2_selector = $CenterContainer/VBoxContainer/CenterContainer4/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect
@onready var player_3_selector = $CenterContainer/VBoxContainer/CenterContainer4/VBoxContainer/CenterContainer/HBoxContainer/ReferenceRect2

@onready var selectors = [selector_1,selector_2,selector_3,selector_4,selector_5,selector_6,selector_7,selector_8,selector_9,selector_10]

const level_1_scene = preload("res://levels/Level1.tscn")
const level_2_scene = preload("res://levels/Level2.tscn")
const level_3_scene = preload("res://levels/Level3.tscn")
const level_5_scene = preload("res://levels/Level5.tscn")

var selected_level = -1
var current_selection = 0
var previous_selection = 0
const NUM_OF_LEVELS = 10

var max_unlocked_level = 10

func _ready() -> void:
	hide_unlocked_levels(max_unlocked_level)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	previous_selection = current_selection
	
	if Input.is_action_just_pressed("ui_cancel"):
		var main_menu_scene = load("res://MainMenu/main_menu.tscn")
		get_parent().add_child(main_menu_scene.instantiate())
		queue_free()
	
	if selected_level == -1:
			
		if Input.is_action_just_pressed("player1_right") or Input.is_action_just_pressed("player2_right"):
			# If level is unselectable
			if current_selection + 1 >= max_unlocked_level:
				return
				
			# If selected level is on the border
			if current_selection % 5 == 4:
				return
				
			current_selection += 1
			set_selected_level(previous_selection, current_selection)
			
		if Input.is_action_just_pressed("player1_left") or Input.is_action_just_pressed("player2_left"):
			# If selected level is on the border
			if current_selection % 5 == 0:
				return
				
			current_selection -= 1
			set_selected_level(previous_selection, current_selection)
			
		if Input.is_action_just_pressed("player1_down") or Input.is_action_just_pressed("player2_down"):
			# If level is unselectable
			if current_selection + 5 >= max_unlocked_level:
				return
				
			# if selected leve is on the border
			if current_selection + 5 >= NUM_OF_LEVELS:
				return
				
			current_selection += 5
			set_selected_level(previous_selection, current_selection)
			
		if Input.is_action_just_pressed("player1_up") or Input.is_action_just_pressed("player2_up"):
			# if selected leve is on the border
			if current_selection - 5 < 0:
				return
				
			current_selection -= 5
			set_selected_level(previous_selection, current_selection)
			
		if Input.is_action_just_pressed("ui_accept"):
			handle_level_selection(current_selection)
			current_selection = 0
	
	else:
		if Input.is_action_just_pressed("player1_right") or Input.is_action_just_pressed("player2_right"):
			# If level is unselectable
			if current_selection + 1 >= 2:
				return
				
			current_selection += 1
			set_selected_player_amount(previous_selection, current_selection)
			
		if Input.is_action_just_pressed("player1_left") or Input.is_action_just_pressed("player2_left"):
			# If selected level is on the border
			if current_selection - 1 < 0:
				return
				
			current_selection -= 1
			set_selected_player_amount(previous_selection, current_selection)
			
			
		if Input.is_action_just_pressed("ui_accept"):
			handle_player_selection(current_selection)
		
func set_selected_level(previous_level: int, level: int) -> void:
	var previous_selector = selectors[previous_level]
	var selector = selectors[level]
	
	previous_selector.get_node("Selected").visible = false
	selector.get_node("Selected").visible = true
	
func set_selected_player_amount(previous_player_amount: int, player_amount: int):
	var previous_selector
	var selector
	
	if previous_player_amount == 0:
		previous_selector = player_2_selector
	if previous_player_amount == 1:
		previous_selector = player_3_selector
	
	if player_amount == 0:
		selector = player_2_selector
	if player_amount == 1:
		selector = player_3_selector
		
	previous_selector.get_node("Selected").visible = false
	selector.get_node("Selected").visible = true
	
func handle_player_selection(player_amount: int) -> void:
	var level_node
	
	await SceneTransition.close_circle()
	
	if selected_level == 0:
		level_node = level_1_scene.instantiate()
	if selected_level == 1:
		level_node = level_2_scene.instantiate()
	if selected_level == 2:
		level_node = level_3_scene.instantiate()
	if selected_level == 4:
		level_node = level_5_scene.instantiate()
		
	get_parent().add_child(level_node)
	level_node.init(player_amount + 2)
	queue_free()
		
	await SceneTransition.open_circle()

func handle_level_selection(level: int) -> void:
	selected_level = level
	player_2_selector.get_node("Selected").visible = true
	
		
func hide_unlocked_levels(max_level: int) -> void:
	for i in range(0, NUM_OF_LEVELS):
		var selector = selectors[i]
		if ( i >= max_level ): 
			
			selector.get_node("Locked").visible = true
			selector.get_node("Option").text = ""
		else :
			selector.get_node("Option").text = "%d" % (i+1)
			selector.get_node("Locked").visible = false
