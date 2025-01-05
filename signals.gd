extends Node

# UI
@warning_ignore("unused_signal")
signal update_player_mission(player : int, missions : Array[Mission])
@warning_ignore("unused_signal")
signal close_player_mission_tab(player : int)
@warning_ignore("unused_signal")
signal expand_player_mission_tab(player : int)
@warning_ignore("unused_signal")
signal update_UI_nb_player(nb_players : int)

# Timer
@warning_ignore("unused_signal")
signal set_timer_value(time: float)
@warning_ignore("unused_signal")
signal start_timer
@warning_ignore("unused_signal")
signal stop_timer
@warning_ignore("unused_signal")
signal timer_ended

# Missions
@warning_ignore("unused_signal")
signal bomb_defused
@warning_ignore("unused_signal")
signal grass_touched(player : int)
