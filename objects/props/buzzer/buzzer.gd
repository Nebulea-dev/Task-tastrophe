extends StaticBody2D

class_name Buzzer

var isButtonReady: bool = false
var isButtonPushed: bool = false
var goToWait: bool = false

signal tryFinishMission(playerId :int)

@export var buzzer_id:int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.press_action.connect(_on_action_pressed)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player: 
		body.press_action.disconnect(_on_action_pressed)

func _on_action_pressed(playerIndex: int,player: Player ) -> void: 
	if not isButtonPushed:
		$AnimationPlayer.play("Push")
		$WaitForRePressTimer.start()
		isButtonPushed = true
		goToWait = true
		
	if isButtonReady:
		isButtonReady = false
		isButtonPushed = false
		goToWait = false
		$AnimationPlayer.play_backwards("Push")
		tryFinishMission.emit(playerIndex)
		



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(isButtonPushed and goToWait):
		$AnimationPlayer.play("Wait")
		goToWait = false


func _on_wait_for_re_press_timer_timeout() -> void:
	isButtonReady = true
	$AnimationPlayer.play("GoPush")
	
