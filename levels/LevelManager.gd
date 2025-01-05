extends Node2D

class_name LevelManager

@onready var level_success_sound = $WinLoseManager/LevelSuccess
@onready var level_fail_sound = $WinLoseManager/LevelFail

@onready var level_success_label = $WinLoseManager/CanvasLayer/LevelSuccessLabel
@onready var level_fail_label = $WinLoseManager/CanvasLayer/LevelFailLabel

var idLevel: int = 2 ;
var isDone: bool = false
var allowedTime = 120.0
var ListMission: Array[Mission] = []
var ListPropsOther = []

var nbMission= 1

var nb_players = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 # Replace with function body.
	readyHook()

func readyHook() -> void:
	ListMission = assignMissionsToPlayers(ListMission)
	nbMission = ListMission.size()
	createPropsForMission()
	initializeTimer(allowedTime)
	updateMissionUI()
	Signals.timer_ended.connect(Missionfail)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func assignMissionsToPlayers(listMissions: Array[Mission]) -> Array[Mission]:
	listMissions.shuffle()
	var currPlayer: int = 0
	for mission in listMissions:
		mission.playerId = currPlayer
		currPlayer = (currPlayer + 1) % nb_players
	return listMissions

func createPropsForMission () -> void :
	var listshrineUse= []
	for mission:Mission in ListMission :
		mission.finshMission.connect(updateMission)
		
		match mission.type : 
			TypeMission.TARGET:
				createPropsForTarget(mission)
			TypeMission.SHRINECHANCE:
				listshrineUse=createPropsForShrine(mission,listshrineUse)
			TypeMission.ZONE:
				createPropsForZone(mission)
			TypeMission.WAIT_FOR_PRESS:
				createPropsForWaitForPress(mission)
			TypeMission.BOMB:
				createPropsForBomb(mission)
				
func createPropsForTarget(mission: Mission) ->  void :
	for child:Node in get_children() :
		if child is TargetManager:
			var target :TargetManager = child
			target.tryFinishMission.connect(mission.testIfMissionFinshed)
			target.AddAuthorizePlayer([true,true,true])

func createPropsForShrine (mission: Mission,listShrineUse :Array)->  Array:
	for child:Node in get_children() :
		if child is ShrineChance and not listShrineUse.has(child) :
			var chance :ShrineChance = child
			chance.shrineChance_finished.connect(mission.testIfMissionFinshed)
			chance.playerAuthorize= mission.playerId
			chance.updateText(mission.missionId)
			listShrineUse.append(child)
	return listShrineUse

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

func createPropsForBomb (mission: Mission) ->  void:
	for child:Node in get_children() :
		if child is Bomb:
			var bomb: Bomb = child
			if bomb.bomb_id == mission.missionId:
				bomb.tryFinishMission.connect(mission.forceFinishMission)


func updateMission(type: int, mission_id: int):
	print("Mission ", type , " : ",mission_id, " finished")
	updateMissionUI()
	nbMission -=1 
	if(nbMission<=0):
		MissionPass()
	
func createPropsforShrine ():
	pass	

func Missionfail ():
	level_fail_label.visible = true
	level_fail_sound.play()
	
	var timer :Timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(changeLevelFail)
	timer.start(6.0)
	
	
func changeLevelFail():
	await SceneTransition.close_circle()
	
	var levelSelector_scene = load("res://MainMenu/LevelSelector.tscn")
	var levelSelector= levelSelector_scene.instantiate()
	get_parent().add_child(levelSelector)
	levelSelector.set_selected_level(levelSelector.current_selection, idLevel)
	levelSelector.current_selection = idLevel
	
	queue_free()
	await SceneTransition.open_circle()
	
	
func MissionPass():
	Signals.stop_timer.emit()
	
	level_success_label.visible = true
	level_success_sound.play()
	
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(changeLevelSucceed)
	add_child(timer)
	
	timer.start(3.0)

func changeLevelSucceed():
	await SceneTransition.close_circle()
	
	var levelSelector_scene = load("res://MainMenu/LevelSelector.tscn")
	var levelSelector = levelSelector_scene.instantiate()
	get_parent().add_child(levelSelector)
	levelSelector.max_unlocked_level = max(idLevel + 1, levelSelector.max_unlocked_level)
	levelSelector.hide_unlocked_levels(levelSelector.max_unlocked_level)
	
	levelSelector.set_selected_level(levelSelector.current_selection, idLevel)
	levelSelector.current_selection= idLevel
	queue_free()
	await SceneTransition.open_circle()

func initializeTimer(initialTime: float):
	Signals.set_timer_value.emit(initialTime)
	Signals.start_timer.emit()
	
func updateMissionUI():
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
