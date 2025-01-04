extends Node

class_name  FixedProps
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player : Player  = get_parent()
	var orientation : int   = player.curr_look*180 /PI
	
	var directionPlayer : int = (orientation /90 )*90

	
	for id in range(4):
		print ()
		var ray : RayCast2D = get_child(id)
		var angle: float = ray.target_position.angle()
		var directionArray: int = angle*180 /PI
 
			
		if(directionArray == directionPlayer   ):
			
			print(orientation ,directionArray) 
			var collider = ray.get_collider()
			if ( collider != null):
				player.propDetected= collider
				collider.call("_onDetection",player)
				
				
				player.inputManager.activated_update.connect(collider._onActivation,4 )
			else :
				var oldCollider= player.propDetected;
				if(oldCollider!=null ):
					oldCollider.call("_onEndDetection",player)
					player.propDetected=null 
