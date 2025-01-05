extends LevelManager

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	idLevel = 3
	isDone = false
	var mission1: Mission = Mission.new(TypeMission.TARGET, 0, 0, false, "Move to the next box")
	var mission2: Mission = Mission.new(TypeMission.ZONE, 0, 1, false, "Touch Grass")
	ListMission = [mission1, mission2]
	ListPropsOther  =[]
	readyHook()
	pass # Replace with function body.
