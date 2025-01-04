extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player : Player  = get_parent()
	var orientation : int   = player.curr_look*180 /PI
	
	var directionPlayer : int = (orientation /90 )*90

	
	for id in range(4):
		var ray : RayCast2D = get_child(id)
		var angle: float = ray.target_position.angle()
		var directionArray: int = angle*180 /PI
		if( player.playerIndex==1): 
			
			if(directionArray == directionPlayer   ):
				
				print(orientation ,directionArray) 
				var collider = ray.get_collider()
				if ( collider != null):
					player.propDetected= collider
					collider.call("_onDetection",player)
				else :
					var oldCollider= player.propDetected;
					if(oldCollider!=null ):
						oldCollider.call("_onEndDetection",player)
						player.propDetected=null 
	#	var collided_entity :KinematicCollision2D =ray.get_collider();
	#if(collided_entity != null):
	#	listCollider.append(collidentity)
	#	print(collider)
		
			
