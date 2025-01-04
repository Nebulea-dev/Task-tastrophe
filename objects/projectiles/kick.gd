extends Node2D

class_name Kick

var curr_velocity = Vector2(0,0)

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
