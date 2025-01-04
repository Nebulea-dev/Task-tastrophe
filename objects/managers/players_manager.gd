extends Node2D

@export var inputManagerNode: Node

var res_player = preload("res://objects/player/Player.tscn")

var nb_players: int = 3

var list_sprites: Array[CompressedTexture2D] = [load("res://Aseprite/Character_Blue.png"), load("res://Aseprite/Character_Green.png"), load("res://Aseprite/Character_Pink.png"), load("res://Aseprite/Character_Yellow.png")]


# TODO setup player positions with the map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for id in range(nb_players):
		var player = res_player.instantiate()
		player.get_node("./PrincipalSprite").texture = list_sprites[id]
		player.playerIndex = id
		player.set_global_position(Vector2(randi_range(0, 100), randi_range(0, 100)))
		
		inputManagerNode.move_update.connect(player._on_player_move)
		inputManagerNode.kick_update.connect(player._on_player_kick)
		inputManagerNode.ping_update.connect(player._on_player_ping)
		call_deferred("add_child", player)
