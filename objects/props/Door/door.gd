extends Node2D




@onready var moveDoorAnimation = $AnimationPlayer

var isOpen : bool = false

#Todo power not all player can open door 
var playerActiveId: int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.press_action.connect(_on_action_pressed)



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.press_action.disconnect(_on_action_pressed)



func _on_action_pressed(playerIndex: int) -> void:
	var collisionShape :CollisionShape2D = get_node("./StaticBody2D/Collision")
		
	if( isOpen):
		moveDoorAnimation.play("Close")
		isOpen=false;
		collisionShape.disabled = false 
	else :
		moveDoorAnimation.play("Open")
		isOpen=true;
		collisionShape.disabled = true 	
		
