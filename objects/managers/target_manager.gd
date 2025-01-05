extends Node2D

class_name TargetManager 
var currTargetList : Array[MoveTarget]
var activatedTargetList : Array[MoveTarget]

var isChallengeStarted : bool = false
var nbInChallenge : int = 3
var currInChallenge : int = -1
var associatedMission : Array =[] 
var authorizePlayerID : Array

signal finishMission(playerId :int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Closed")
	
	var targetList: Node2D = get_parent().get_node("./MoveTargetList")

	for child in targetList.get_children():
		if child is MoveTarget:
			currTargetList.append(child)
			child.target_finished.connect(_on_target_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.qs
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		#if authorize 
		body.press_action.connect(_on_action_pressed)



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.press_action.disconnect(_on_action_pressed)


func _on_target_finished(player:Player) -> void:
	currInChallenge -= 1
	if(currInChallenge > 0):
		$TargetCloseSound.play()
	else:
		$FinishTargetsSound.play()
		$AnimationPlayer.play("Closed")
		isChallengeStarted = false
		finishMission.emit(player.playerIndex) 

func _on_action_pressed(playerIndex: int, _player: Player) -> void:
	if not isChallengeStarted:
		isChallengeStarted = true
		$StartSound.play()
		currTargetList.shuffle()
		currInChallenge = nbInChallenge
		for i in range(nbInChallenge):
			var currTarget: MoveTarget = currTargetList[i]
			activatedTargetList.append(currTarget)
			currTarget.open_target(playerIndex)
		
		$AnimationPlayer.play("ReallyOpen")	
		
func connectMission(idMission : int )->void :
	associatedMission.append(idMission)
	pass
	
func SetAuthorizePlayer(authorizePlayer: Array)-> void :
	authorizePlayerID=authorizePlayer
