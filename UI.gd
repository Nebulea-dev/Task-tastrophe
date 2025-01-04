extends Control

@onready var Player_1_text = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer/TextureRect/MarginContainer/Player_1_text
@onready var Player_2_text = $CanvasLayer/VBoxContainer/HBoxContainer/HBoxContainer2/TextureRect/MarginContainer/Player_2_text
@onready var Player_3_text = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer/TextureRect/MarginContainer/Player_3_text
@onready var Player_4_text = $CanvasLayer/VBoxContainer/HBoxContainer2/HBoxContainer2/TextureRect/MarginContainer/Player_4_text

func _ready() -> void:
	Signals.update_player_mission.connect(_on_update_player_mission)


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
		if mission.done:
			player_missions.append_text("[color=#636363]• " + mission.text + "[/color]\n")
			
		else:
			player_missions.append_text("• " + mission.text + "\n")
