extends CharacterBody2D

class_name Player

var kick_res = preload("res://objects/projectiles/Kick.tscn")
var ping_res = preload("res://objects/projectiles/Ping.tscn")

signal press_action(playerIndex: int, player: Player)

@onready var playerAnimation = $AnimationPlayer

@export var move_factor : float = 0.2
@export var speed : int = 500

var inputManager :Node 

var playerIndex : int = 0
var targetDir : Vector2 = Vector2(0, 0)
var real_velocity : Vector2
var curr_look : float = 0 

var kick_distance : float = 50
var kick_speed : float = 50
var can_kick : bool = true

var propDetected: Node2D 
var can_ping : bool = true

var push_force = 80.0
var launch_force = 1500.0

var prop_in_hand: PortableProps = null

var prop_mutex : Mutex = Mutex.new()
var nb_prop_connected: int = 0
var prop_drop_distance: float = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KeyAnimationPlayer.play("default")


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
			if collider is RigidBody2D:
				collider.apply_central_impulse(-collided_entity.get_normal() * push_force)
			else:
				collided_entity = move_and_collide(velocity.project(collided_entity.get_normal().orthogonal()) * delta);
				if(collided_entity != null):
					real_velocity = collided_entity.get_remainder()
	else:
		real_velocity = velocity
	
	$KeySprite.visible =  press_action.get_connections().size() > 0


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


func _on_player_action(activation_array : Array[bool]) -> void:
	if(activation_array[playerIndex]):
		press_action.emit(playerIndex, self)
		$ClickSound.play()

func carry_prop(prop: PortableProps) -> void:
	prop_mutex.lock()
	drop_current_prop(false)
	add_prop_to_hand(prop)
	prop_mutex.unlock()

func drop_current_prop(take_mutex: bool) -> void:
	if take_mutex: 
		prop_mutex.lock()

	var curr_prop = prop_in_hand
	if prop_in_hand:
		prop_in_hand = null
		curr_prop.process_mode = Node.PROCESS_MODE_INHERIT
		curr_prop.get_parent().remove_child(curr_prop)
		call_deferred("add_child_custom", curr_prop)
		curr_prop.linear_velocity = velocity
		curr_prop.set_global_position(global_position + Vector2(0, 20) + Vector2.from_angle(curr_look) * prop_drop_distance)
		curr_prop.apply_central_impulse(Vector2.from_angle(curr_look) * launch_force)
	
	if take_mutex: 
		prop_mutex.unlock()

func add_prop_to_hand(prop: PortableProps) -> void:
	prop_in_hand = prop
	prop.process_mode = Node.PROCESS_MODE_DISABLED
	prop.get_parent().remove_child(prop)
	call("add_child", prop)
	prop.set_position(Vector2(0,-30))
	
func add_child_custom(prop: PortableProps):
	get_parent().get_parent().add_child(prop)

func _on_player_drop(drop_array : Array[bool]) -> void:
	if drop_array[playerIndex]:
		prop_mutex.lock()
		drop_current_prop(false)
		prop_mutex.unlock()
