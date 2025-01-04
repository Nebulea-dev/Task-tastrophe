extends Node2D

class_name Kick

var curr_velocity: Vector2 = Vector2(0,0)
var kick_deplacement: int = 50
var push_force = 5000.0

var creator : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += curr_velocity * delta
	global_rotation = curr_velocity.angle() + PI

func set_velocity(target_velocity: Vector2):
	curr_velocity = target_velocity

func _on_kick_duration_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == creator:
		return
	if body is RigidBody2D:
		body.apply_central_impulse(curr_velocity.normalized() * push_force)
	else:
		if body is CharacterBody2D:
			body.move_and_collide(curr_velocity.normalized() * kick_deplacement)
