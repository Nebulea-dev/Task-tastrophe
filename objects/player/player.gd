extends CharacterBody2D


var playerIndex : int = 0
var currentSpeed : Vector2 = Vector2(0, 0)
var targetDir : Vector2 = Vector2(0, 0)
var speed : int = 500
#var acceleration_frames = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentSpeed = targetDir * speed
	#currentSpeed += (targetDir * speed) / acceleration_frames
	#if currentSpeed.length() > speed:
		#currentSpeed = targetDir
	move_and_collide(currentSpeed * delta);
	
	
func _on_player_move_x(move_x : Array[float]) -> void:
	targetDir.x = move_x[playerIndex]
	if targetDir.length() > 1:
		targetDir = targetDir.normalized()

func _on_player_move_y(move_y : Array[float]) -> void:
	targetDir.y = move_y[playerIndex]
	if targetDir.length() > 1:
		targetDir = targetDir.normalized()
