extends Control

@onready var Player_1_text = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer/ReferenceRect/NinePatchRect/ReferenceRect/Player_1_text
@onready var Player_2_text = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer2/ReferenceRect/NinePatchRect/ReferenceRect/Player_2_text
@onready var Player_3_text = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer/ReferenceRect/NinePatchRect/ReferenceRect/Player_3_text
@onready var Player_4_text = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer2/ReferenceRect/NinePatchRect/ReferenceRect/Player_4_text

@onready var Player_1_tab = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer/ReferenceRect/NinePatchRect
@onready var Player_2_tab = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer2/ReferenceRect/NinePatchRect
@onready var Player_3_tab = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer/ReferenceRect/NinePatchRect
@onready var Player_4_tab = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer2/ReferenceRect/NinePatchRect

func _ready() -> void:
	Signals.update_player_mission.connect(_on_update_player_mission)
	
	expand_player_mission_tab(0)
	expand_player_mission_tab(1)
	expand_player_mission_tab(2)
	expand_player_mission_tab(3)
	
	close_player_mission_tab(0)
	close_player_mission_tab(1)
	close_player_mission_tab(2)
	close_player_mission_tab(3)


func _on_update_player_mission(player: int, missions: Array[Mission]):
	var player_missions: Node
	match player:
		0:
			player_missions = Player_1_text
		1:
			player_missions = Player_2_text
		2:
			player_missions = Player_3_text
		3:
			player_missions = Player_4_text
		_:
			print("_on_update_player_mission recieved an unexpected player number : ", player)
			
	player_missions.clear()
	
	for mission in missions:
		if !mission.done:
			player_missions.append_text("• " + mission.text + "\n")
	
	for mission in missions:
		if mission.done:
			player_missions.append_text("[color=#636363]• " + mission.text + "[/color]\n")
			
func close_player_mission_tab(player: int):
	var player_missions_text: Node
	match player:
		0:
			player_missions_text = Player_1_text
		1:
			player_missions_text = Player_2_text
		2:
			player_missions_text = Player_3_text
		3:
			player_missions_text = Player_4_text
		_:
			print("_on_update_player_mission recieved an unexpected player number : ", player)
			
	var player_missions_tab: Node
	match player:
		0:
			player_missions_tab = Player_1_tab
		1:
			player_missions_tab = Player_2_tab
		2:
			player_missions_tab = Player_3_tab
		3:
			player_missions_tab = Player_4_tab
		_:
			print("_on_update_player_mission recieved an unexpected player number : ", player)
			
	player_missions_tab.size = Vector2(50, 20)
	player_missions_tab.position = Vector2(0, 0)
	player_missions_text.size = Vector2(448, 167)
			
func expand_player_mission_tab(player: int):
	var player_missions_text: Node
	match player:
		0:
			player_missions_text = Player_1_text
		1:
			player_missions_text = Player_2_text
		2:
			player_missions_text = Player_3_text
		3:
			player_missions_text = Player_4_text
		_:
			print("_on_update_player_mission recieved an unexpected player number : ", player)
			
	var player_missions_tab: Node
	match player:
		0:
			player_missions_tab = Player_1_tab
		1:
			player_missions_tab = Player_2_tab
		2:
			player_missions_tab = Player_3_tab
		3:
			player_missions_tab = Player_4_tab
		_:
			print("_on_update_player_mission recieved an unexpected player number : ", player)
			
	player_missions_tab.size = Vector2(50, 70)
	if player == 2 or player == 3:
		player_missions_tab.position = Vector2(0, -500)
	else:
		player_missions_tab.position = Vector2(0, 0)
	player_missions_text.size = Vector2(448, 680)
	
