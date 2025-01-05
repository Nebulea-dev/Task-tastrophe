extends Node2D

class_name LevelManager

var idLevel: int = 2 ;
var isDone: bool = false
var allowedTime = 10#120.0
var ListMission: Array[Mission] = []
var ListPropsOther = []
var nbMission= 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 # Replace with function body.
	readyHook()

func readyHook() -> void:
	createPropsForMission()
	initializeTimer(allowedTime)
	updateMissionUI()
	Signals.timer_ended.connect(Missionfail)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func createPropsForMission () -> void :
	for mission:Mission in ListMission :
		mission.finshMission.connect(updateMission)
		match mission.type : 
			TypeMission.TARGET:
				createPropsForTarget(mission)
			TypeMission.SHRINECHANCE:
				createPropsForShrine()
			TypeMission.ZONE:
				createPropsForZone(mission)
			TypeMission.WAIT_FOR_PRESS:
				createPropsForWaitForPress(mission)
				
func createPropsForTarget(mission: Mission) ->  void :
	for child:Node in get_children() :
		if child is TargetManager:
			var target :TargetManager = child
			target.tryFinishMission.connect(mission.testIfMissionFinshed)


func createPropsForShrine ()->  void:
	pass

func createPropsForZone (mission: Mission) ->  void:
	for child:Node in get_children() :
		if child is ZoneDetector:
			var zone: ZoneDetector = child
			if zone.detector_id == mission.missionId:
				zone.tryFinishMission.connect(mission.testIfMissionFinshed)

func createPropsForWaitForPress (mission: Mission) ->  void:
	for child:Node in get_children() :
		if child is Buzzer:
			var buzzer: Buzzer = child
			if buzzer.buzzer_id == mission.missionId:
				buzzer.tryFinishMission.connect(mission.testIfMissionFinshed)


func updateMission(type: int, mission_id: int):
	print("Mission ", type , " : ",mission_id, " finished")
	updateMissionUI()
	nbMission -=1 
	if(nbMission<=0):
		MissionPass()
	
func createPropsforShrine ():
	pass	

func Missionfail ():
	# Ecran de echec 
	var timer :Timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(changeLevelFail)
	timer.start(5.0)
	pass
	
func changeLevelFail()	:
	var levelSelector_scene = load("res://MainMenu/LevelSelector.tscn")
	var levelSelector= levelSelector_scene.instantiate()
	get_parent().add_child(levelSelector)
	levelSelector.set_selected_level(levelSelector.current_selection , idLevel)
	levelSelector.current_selection= idLevel
	queue_free()
	pass
func MissionPass ():
	Signals.stop_timer.emit()
	# Ecran de victoire 
	var timer :Timer = Timer.new()
	
	timer.one_shot = true
	
	add_child(timer)
	timer.timeout.connect(changeLevelSucceed)
	timer.start(3.0)

func changeLevelSucceed()	:
	var levelSelector_scene = load("res://MainMenu/LevelSelector.tscn")
	var levelSelector= levelSelector_scene.instantiate()
	get_parent().add_child(levelSelector)
	levelSelector.max_unlocked_level= max (idLevel+1 , levelSelector.max_unlocked_level)
	levelSelector.hide_unlocked_levels(levelSelector.max_unlocked_level)
	
	levelSelector.set_selected_level(levelSelector.current_selection , idLevel)
	levelSelector.current_selection= idLevel
	queue_free()
	pass

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
