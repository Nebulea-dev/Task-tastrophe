extends Node

signal move_update(move_x : Array[float], move_y : Array[float])
signal kick_update(players_concerned: Array[bool])
signal ping_update(players_concerned: Array[bool])
signal activated_update(players_concerned: Array[bool])
signal drop_update(players_concerned: Array[bool])

static var move_directions_x:Array[float] = [0,0,0]
static var move_directions_y:Array[float] = [0,0,0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_input()
	update_kick_input()
	update_ping_input()
	update_activation_input()
	update_drop_input()
	if Input.is_action_just_pressed("ui_cancel"):
		await SceneTransition.close_circle()
		var main_menu_scene = load("res://MainMenu/main_menu.tscn")
		get_parent().get_parent().add_child(main_menu_scene.instantiate())
		get_parent().queue_free()
		await SceneTransition.open_circle()

func update_input():
	# Horizontal input
	if Input.is_action_pressed("player1_left"):
		move_directions_x[0] = -Input.get_action_strength("player1_left")
	else:
		if Input.is_action_pressed("player1_right"):
			move_directions_x[0] = Input.get_action_strength("player1_right")
		else:
			move_directions_x[0] = 0
			
	if Input.is_action_pressed("player2_left"):
		move_directions_x[1] = -Input.get_action_strength("player2_left")
	else:
		if Input.is_action_pressed("player2_right"):
			move_directions_x[1] = Input.get_action_strength("player2_right")
		else:
			move_directions_x[1] = 0
			
	if Input.is_action_pressed("player3_left"):
		move_directions_x[2] = -Input.get_action_strength("player3_left")
	else:
		if Input.is_action_pressed("player3_right"):
			move_directions_x[2] = Input.get_action_strength("player3_right")
		else:
			move_directions_x[2] = 0
			
			
	# Vertical input
	if Input.is_action_pressed("player1_up"):
		move_directions_y[0] = -Input.get_action_strength("player1_up")
	else:
		if Input.is_action_pressed("player1_down"):
			move_directions_y[0] = Input.get_action_strength("player1_down")
		else:
			move_directions_y[0] = 0
		
	if Input.is_action_pressed("player2_up"):
		move_directions_y[1] = -Input.get_action_strength("player2_up")
	else:
		if Input.is_action_pressed("player2_down"):
			move_directions_y[1] = Input.get_action_strength("player2_down")
		else:
			move_directions_y[1] = 0
		
	if Input.is_action_pressed("player3_up"):
		move_directions_y[2] = -Input.get_action_strength("player3_up")
	else:
		if Input.is_action_pressed("player3_down"):
			move_directions_y[2] = Input.get_action_strength("player3_down")
		else:
			move_directions_y[2] = 0

	move_update.emit(move_directions_x, move_directions_y)
	
	# Mission tab expansion
	if Input.is_action_just_pressed("player1_mission"):
		Signals.expand_player_mission_tab.emit(0)
		
	if Input.is_action_just_released("player1_mission"):
		Signals.close_player_mission_tab.emit(0)
		
	if Input.is_action_just_pressed("player2_mission"):
		Signals.expand_player_mission_tab.emit(1)
		
	if Input.is_action_just_released("player2_mission"):
		Signals.close_player_mission_tab.emit(1)
		
	if Input.is_action_just_pressed("player3_mission"):
		Signals.expand_player_mission_tab.emit(2)
		
	if Input.is_action_just_released("player3_mission"):
		Signals.close_player_mission_tab.emit(2)


func update_kick_input() -> void:
	var player_kick : Array[bool] = [false, false, false]

	if Input.is_action_just_pressed("player1_kick"):
		player_kick[0] = true

	if Input.is_action_just_pressed("player2_kick"):
		player_kick[1] = true

	if Input.is_action_just_pressed("player3_kick"):
		player_kick[2] = true

	kick_update.emit(player_kick)


func update_ping_input() -> void:
	var player_ping : Array[bool] = [false, false, false]

	if Input.is_action_just_pressed("player1_ping"):
		player_ping[0] = true

	if Input.is_action_just_pressed("player2_ping"):
		player_ping[1] = true

	if Input.is_action_just_pressed("player3_ping"):
		player_ping[2] = true

	ping_update.emit(player_ping)

func update_activation_input() -> void:
	var player_activation : Array[bool] = [false, false, false]
	if Input.is_action_just_pressed("player1_activated"):
		player_activation[0] = true

	if Input.is_action_just_pressed("player2_activated"):
		player_activation[1] = true

	if Input.is_action_just_pressed("player3_activated"):
		player_activation[2] = true

	activated_update.emit(player_activation)

func update_drop_input() -> void:
	var player_drop : Array[bool] = [false, false, false]
	if Input.is_action_just_pressed("player1_drop"):
		player_drop[0] = true

	if Input.is_action_just_pressed("player2_drop"):
		player_drop[1] = true

	if Input.is_action_just_pressed("player3_drop"):
		player_drop[2] = true

	drop_update.emit(player_drop)
