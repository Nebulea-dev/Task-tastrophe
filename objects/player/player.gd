extends CharacterBody2D

var kick_res = preload("res://objects/projectiles/Kick.tscn")
var ping_res = preload("res://objects/projectiles/Ping.tscn")

@onready var playerAnimation = $AnimationPlayer

@export var move_factor : float = 0.2
@export var speed : int = 500

var playerIndex : int = 0
var targetDir : Vector2 = Vector2(0, 0)
var real_velocity : Vector2
var curr_look : float = 0 

var kick_distance : float = 50
var kick_speed : float = 50
var can_kick : bool = true

var can_ping : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = targetDir * speed
	if(targetDir.length() > 0.01):
		curr_look = targetDir.angle()

	var collided_entity: KinematicCollision2D = move_and_collide(velocity * delta);
	if(collided_entity != null):
		var collider : Node2D = collided_entity.get_collider()
		real_velocity = collided_entity.get_remainder()
		if (collider is CharacterBody2D):
			collider.move_and_collide(velocity.length() * move_factor * delta * (collider.global_position - global_position).normalized())
		else:
			collided_entity = move_and_collide(velocity.project(collided_entity.get_normal().orthogonal()) * delta);
			if(collided_entity != null):
				real_velocity = collided_entity.get_remainder()
	else:
		real_velocity = velocity


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

	var mission1: Mission = Mission.new(false, "Move to the next box")
	var mission2: Mission = Mission.new(true, "Defuse da [img width=\"50\" height=\"50\"]res://Aseprite/Bomb.png[/img]")
	var mission3: Mission = Mission.new(false, "Touch grass")
	
	var missions: Array[Mission] = [mission1, mission2, mission3]
	Signals.update_player_mission.emit(playerIndex, missions)
		
	if targetDir.x == 0 && targetDir.y == 0:
		playerAnimation.stop()

func _on_player_kick(kick_array : Array[bool]) -> void:
	if can_kick:
		if(kick_array[playerIndex]):
			$KickCooldown.start()
			$KickHitSound.play()
			var kick: Kick = kick_res.instantiate()
			kick.set_global_position(position + Vector2(0, 20) + Vector2.from_angle(curr_look) * kick_distance)
			kick.set_global_rotation(curr_look + PI)
			kick.set_velocity(Vector2.from_angle(curr_look) * kick_speed + real_velocity)
			kick.creator = self
			get_parent().add_child(kick)
			can_kick = false


func _on_kick_cooldown_timeout() -> void:
	$KickReloadSound.play()
	can_kick = true


func _on_player_ping(kick_array : Array[bool]) -> void:
	if can_ping:
		if(kick_array[playerIndex]):
			$PingCooldown.start()
			$PingSound.play()
			call_deferred("add_child", ping_res.instantiate())
			can_ping = false
		
func _on_ping_cooldown_timeout() -> void:
	can_ping = true
