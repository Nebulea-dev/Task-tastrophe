extends Node

signal move_update(move_x : Array[float], move_y : Array[float])
signal kick_update(players_concerned: Array[bool])

static var move_directions_x:Array[float] = [0,0,0]
static var move_directions_y:Array[float] = [0,0,0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_input()
	update_kick_input()
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

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

	move_update.emit(move_directions_x, move_directions_y)


func update_kick_input() -> void:
	var player_kick : Array[bool] = [false, false, false]

	if Input.is_action_just_pressed("player1_kick"):
		player_kick[0] = true

	if Input.is_action_just_pressed("player2_kick"):
		player_kick[1] = true

	kick_update.emit(player_kick)
	
#Interactions
