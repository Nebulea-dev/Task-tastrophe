extends Node2D

@onready var moveDoorAnimation = $AnimationPlayer
@onready var collisionShape: CollisionShape2D = $StaticBody2D/Collision

var isOpen : bool = false

#Todo power not all player can open door 
var playerActiveId: int = -1

func _ready() -> void:
	collisionShape.disabled = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if body is Player:
		#body.press_action.connect(_on_action_pressed)



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.press_action.disconnect(_on_action_pressed)



func _on_action_pressed(playerIndex: int, _player: Player) -> void:
	if(isOpen):
		moveDoorAnimation.play("Close")
		isOpen=false;
		collisionShape.disabled = false 
	else :
		moveDoorAnimation.play("Open")
		isOpen=true;
		collisionShape.disabled = true
