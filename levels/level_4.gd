extends LevelManager

# Called when the node enters the scene tree for the first time.

func init(_nb_players: int) -> void:
	nb_players = _nb_players
	idLevel = 3
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Do the target box")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	var mission3: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 0, 1, false, "Press the button 0 twice")
	var mission4: Mission = Mission.new(TypeMission.BOMB, 0, 1, false, "Defuse bomb 0")
	var mission5: Mission = Mission.new(TypeMission.BOMB, 1, 1, false, "Defuse bomb 1")
	var mission6: Mission = Mission.new(TypeMission.SHRINECHANCE, 1, 0, false, "Succeed at the luck chance")
	var mission7: Mission = Mission.new(TypeMission.SHRINECHANCE, 0, 0, false, "Succeed at the luck chance")
	ListMission = [mission1, mission2, mission3, mission4, mission5, mission6, mission7]
	ListPropsOther  =[]
	readyHook()
