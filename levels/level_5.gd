extends LevelManager

# Called when the node enters the scene tree for the first time.

func init(_nb_players: int) -> void:
	nb_players = _nb_players
	idLevel = 4
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Move to the targets")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	var mission3: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 0, 1, false, "Press Twice Button 0")
	var mission4: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 1, 1, false, "Press Twice Button 1")
	var mission5: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 2, 1, false, "Press Twice Button 2")
	var mission6: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 3, 1, false, "Press Twice Button 3")
	var mission7: Mission = Mission.new(TypeMission.BOMB, 0, 1, false, "Defuse bomb 0")
	var mission8: Mission = Mission.new(TypeMission.BOMB, 1, 1, false, "Defuse bomb 1")
	var mission9: Mission = Mission.new(TypeMission.BOMB, 2, 1, false, "Defuse bomb 2")
	var mission10: Mission = Mission.new(TypeMission.BOMB, 3, 1, false, "Defuse bomb 3")
	ListMission = [mission1, mission2, mission3, mission4, mission5, mission6, mission7, mission8, mission9, mission10]
	ListPropsOther  =[]
	readyHook()
