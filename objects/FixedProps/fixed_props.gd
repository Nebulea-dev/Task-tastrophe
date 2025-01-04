extends StaticBody2D

class_name fixedProps  

signal update_player_mission(player : int, missions : Array[Mission])

var playerDetected :Player =null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func _onDetection(player:Player )->void :
	# signal to print the key
	#keep id player
	
	playerDetected = player
	
	
func _onEndDetection(player :Player)-> void :
	if (playerDetected !=null or player==playerDetected ):
		playerDetected=null
	#emit signal to end key print 
