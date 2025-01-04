extends Node2D

var currTargetList : Array[MoveTarget]
var activatedTargetList : Array[MoveTarget]

var isChallengeStarted : bool = false
var nbInChallenge : int = 3
var currInChallenge : int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var targetList: Node2D = get_parent().get_node("./MoveTargetList")

	for child in targetList.get_children():
		if child is MoveTarget:
			currTargetList.append(child)
			child.target_finished.connect(_on_target_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.qs
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not isChallengeStarted:
		if body is Player:
			isChallengeStarted = true
			$StartSound.play()
			currTargetList.shuffle()
			currInChallenge = nbInChallenge
			for i in range(nbInChallenge):
				var currTarget: MoveTarget = currTargetList[i]
				activatedTargetList.append(currTarget)
				currTarget.open_target(body.playerIndex)

func _on_target_finished() -> void:
	currInChallenge -= 1
	if(currInChallenge > 0):
		$TargetCloseSound.play()
	else:
		$FinishTargetsSound.play()
		isChallengeStarted = false
