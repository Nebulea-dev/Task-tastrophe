extends LevelManager

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	idLevel = 3
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Move to the next box")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	var mission3: Mission = Mission.new(TypeMission.WAIT_FOR_PRESS, 0, 1, false, "Press the button twice")
	ListMission = [mission1, mission2, mission3]
	ListPropsOther  =[]
	readyHook()
