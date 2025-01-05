class_name Mission

var done: bool = false
var text: String = ""
var playerId:int
var type  
var missionId :int = 5

signal finshMission(type_mission: int, mission_id: int)

func _init(type_mission : int, id_mission: int, playerid: int, _done: bool, _text: String):
	type = type_mission
	playerId = playerid
	missionId = id_mission
	done = _done
	text = _text


func testIfMissionFinshed(id_player: int)->void :
	print("Player ", id_player, " Finished mission ", type, "; ", missionId)
	if(id_player == playerId):
		finshMission.emit(type, missionId)
