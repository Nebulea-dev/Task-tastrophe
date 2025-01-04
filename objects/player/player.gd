extends CharacterBody2D

@onready var playerAnimation = $AnimationPlayer


var playerIndex : int = 0
var move_factor : float = 0.2
var targetDir : Vector2 = Vector2(0, 0)
var speed : int = 500
#var acceleration_frames = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = targetDir * speed
	#currentSpeed += (targetDir * speed) / acceleration_frames
	#if currentSpeed.length() > speed:
		#currentSpeed = targetDir
	var collided_entity: KinematicCollision2D = move_and_collide(velocity * delta);
	if(collided_entity != null):
		var collider : Node2D = collided_entity.get_collider()
		print(collider)
		if (collider is CharacterBody2D):
			collider.move_and_collide(velocity.length() * move_factor * delta * (collider.global_position - global_position).normalized())
	
func _on_player_move(move_x : Array[float], move_y : Array[float]) -> void:
	targetDir.x = move_x[playerIndex]
	if targetDir.length() > 1:
		targetDir = targetDir.normalized()
		
		
	targetDir.y = move_y[playerIndex]
	if targetDir.length() > 1:
		targetDir = targetDir.normalized()
		
	if targetDir.y < 0:
		playerAnimation.play("Up")
		
	if targetDir.y > 0:
		playerAnimation.play("Down")
		
	if targetDir.x < 0 && targetDir.y == 0:
		playerAnimation.play("Left")
		
	if targetDir.x > 0 && targetDir.y == 0:
		playerAnimation.play("Right")
		
	if targetDir.x == 0 && targetDir.y == 0:
		playerAnimation.stop()
