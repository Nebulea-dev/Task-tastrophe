extends Node

signal update_player_mission(player : int, missions : Array[Mission])
signal close_player_mission_tab(player : int)
signal expand_player_mission_tab(player : int)

signal set_timer_value(time: float)
signal start_timer
signal stop_timer

signal bomb_defused
