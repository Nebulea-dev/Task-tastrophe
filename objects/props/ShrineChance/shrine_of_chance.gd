extends StaticBody2D

signal shrineChance_finished

@onready var moveDoorAnimation = $AnimationPlayer

var isDone : bool = false
var playerActiveId: int = -1
var probaSuccess :int =50
var ListPosition : Array = []
var ListplayerEntered =[false,false,false]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and !isDone:
		body.press_action.connect(_on_action_pressed)
		ListplayerEntered [body.playerIndex] = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player  : #and !isDone
		body.press_action.disconnect(_on_action_pressed)
		ListplayerEntered [body.playerIndex] = false


func _on_action_pressed(playerIndex: int) -> void: # todo  player: Player
	
	if(!isDone):
		var rand : int = randi_range(0,99)
		if( rand >= probaSuccess ) :
			moveDoorAnimation.play("TryFail")
		else :
			#toDo remove interaction 
			moveDoorAnimation.play("TrySucceed")
			#var allPlayer = player.getparent().getchildren()
			#for p in allPlayer :
				#if ( ListplayerEntered [p.playerIndex]):
					#p.press_action.disconnect(_on_action_pressed)
					#ListplayerEntered [p.playerIndex] = false
			isDone=true
