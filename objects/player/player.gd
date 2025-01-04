extends CharacterBody2D

var kick_res = preload("res://objects/projectiles/Kick.tscn")

@onready var playerAnimation = $AnimationPlayer

@export var move_factor : float = 0.2
@export var speed : int = 500

var playerIndex : int = 0
var targetDir : Vector2 = Vector2(0, 0)
var curr_look : float = 0 
var kick_distance : float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = targetDir * speed
	if(targetDir.length() > 0.01):
		curr_look = targetDir.angle()
		print(curr_look)

	#currentSpeed += (targetDir * speed) / acceleration_frames
	#if currentSpeed.length() > speed:
		#currentSpeed = targetDir
	var collided_entity: KinematicCollision2D = move_and_collide(velocity * delta);
	if(collided_entity != null):
		var collider : Node2D = collided_entity.get_collider()
		
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

func _on_player_kick(kick_array : Array[bool]) -> void:
	if(kick_array[playerIndex]):
		var kick: Kick = kick_res.instantiate()
		kick.set_global_position(position + Vector2.from_angle(curr_look) * kick_distance)
		kick.set_global_rotation(curr_look + PI)
		get_parent().add_child(kick)
