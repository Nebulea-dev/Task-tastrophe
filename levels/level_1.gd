extends LevelManager

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	idLevel = 3
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Move to the target box")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	var mission3: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 0, 1, false, "Press the button 0 twice")
	var mission4: Mission = Mission.new(TypeMission.BOMB, 0, 1, false, "Defuse bomb 0")
	var mission5: Mission = Mission.new(TypeMission.BOMB, 1, 1, false, "Defuse bomb 1")
	var mission6: Mission = Mission.new(TypeMission.SHRINECHANCE, 0, 0, false, "Succeed at the luck chance")
	ListMission = [mission1, mission2, mission3, mission4, mission5]
	ListPropsOther = []
	readyHook()
