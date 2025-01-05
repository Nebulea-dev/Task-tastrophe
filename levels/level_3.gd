extends LevelManager

# Called when the node enters the scene tree for the first time.

func init(_nb_players: int) -> void:
	nb_players = _nb_players
	idLevel = 3
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Move to the targets")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	var mission3: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 0, 1, false, "Press Twice Button 0")
	var mission4: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 1, 1, false, "Press Twice Button 1")
	ListMission = [mission1, mission2, mission3, mission4]
	ListPropsOther  =[]
	readyHook()
