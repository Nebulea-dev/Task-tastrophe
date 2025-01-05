extends Node2D

class_name LevelManager

var idLevel: int = 0 ;
var isDone: bool = false
var allowedTime = 120.0
var ListMission: Array[Mission] = []
var ListPropsOther = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 # Replace with function body.
	readyHook()

func readyHook() -> void:
	createPropsForMission()
	initializeTimer(allowedTime)
	updateMissionUI()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func createPropsForMission () -> void :
	
	for mission:Mission in ListMission :
		mission.finshMission.connect(updateMission)
		match mission.type : 
			mission.TypeMission.TARGET:
				createPropsforTarget(mission)
			mission.TypeMission.SHRINECHANCE:	
				createPropsforShrine()
				
func createPropsforTarget (mission: Mission) ->  void :
	for child:Node in get_children() :
		if child is TargetManager:
			var target :TargetManager = child
			target.finishMission.connect(mission.testifMissionFinnshed)
	pass

func createPropsforShrine ()->  void:
	
	pass
func updateMission(missionid:int):
	print("Mission ",missionid, "finnished")
	updateMissionUI()
	
func initializeTimer(initialTime: float):
	Signals.set_timer_value.emit(initialTime)
	Signals.start_timer.emit()
	
func updateMissionUI():
	#var mission1: Mission = Mission.new(false, "Move to the next box")
	#var mission2: Mission = Mission.new(true, "Defuse da [img width=\"50\" height=\"50\"]res://Aseprite/Bomb.png[/img]")
	#var mission3: Mission = Mission.new(false, "Touch grass")
	#var mission4: Mission = Mission.new(true, "Get a haircut")
	
	#var missions: Array[Mission] = [mission1, mission2, mission3, mission4]
	
	var missions_player1: Array[Mission]
	var missions_player2: Array[Mission]
	var missions_player3: Array[Mission]
	var missions_player4: Array[Mission]
	
	for mission in ListMission:
		if mission.playerId == 0:
			missions_player1.append(mission)
		if mission.playerId == 1:
			missions_player2.append(mission)
		if mission.playerId == 2:
			missions_player3.append(mission)
		if mission.playerId == 3:
			missions_player4.append(mission)
			
	Signals.update_player_mission.emit(0, missions_player1)
	Signals.update_player_mission.emit(1, missions_player2)
	Signals.update_player_mission.emit(2, missions_player3)
	Signals.update_player_mission.emit(3, missions_player4)
