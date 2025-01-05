class_name Mission

enum TypeMission {
  TARGET,
  SHRINECHANCE,
  MAGE,
}
var done: bool = false
var text: String = ""
var playerId:int
var type  
var missionId :int = 5

signal finshMission(misssion_id: int )

func _init(typemission , playerid , _done, _text):
	type=typemission
	playerId=playerid
	done = _done
	text = _text


func testifMissionFinnshed(idplayer)->void :
	if(idplayer == playerId ):
		finshMission.emit(missionId)
	
