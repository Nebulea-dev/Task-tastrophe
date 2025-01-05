extends Node2D

class_name LevelManager



var idLevel :int = 0 ;
var isDone:bool =false
var ListMission : Array= []
var ListPropsOther=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 # Replace with function body.
	readyHook()

func readyHook() -> void:
	createPropsForMission()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
