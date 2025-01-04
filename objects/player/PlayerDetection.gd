extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player :Node2D = get_parent()
	var orientation : int  = player.global_rotation_degrees
	var directionPlayer : int = (orientation /90 )*90
	
	
	for id in range(4):
		var ray : RayCast2D = get_child(id)
		var directionArray: float = ray.target_position.angle()*180 /PI#get_meta("Direction")
		if(directionArray== directionPlayer ): 
			var collider = ray.get_collider()
			print(collider)
	#	var collided_entity :KinematicCollision2D =ray.get_collider();
	#if(collided_entity != null):
	#	listCollider.append(collidentity)
	#	print(collider)
		
			
