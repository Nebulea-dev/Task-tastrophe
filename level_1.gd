extends LevelManager



# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	idLevel  = 3
	isDone =false
	var mission1: Mission = Mission.new(0, 0,false, "Move to the next box")
	ListMission = [mission1]
	ListPropsOther  =[]
	readyHook()
	pass # Replace with function body.
