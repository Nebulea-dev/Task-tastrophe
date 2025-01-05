extends StaticBody2D

signal shrineChance_finished

@onready var moveDoorAnimation = $AnimationPlayer

var isDone : bool = false
var playerActiveId: int = -1
var probaSuccess :int =25
var indexPosition=1
var nbIndexPosition=2
var ListPosition : Array = [Vector2 (1400,400),Vector2(400,400)]
var ListplayerEntered =[false,false,false]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(ListPosition[0])
	global_position = ListPosition[0]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and !isDone:
		body.press_action.connect(_on_action_pressed)
		ListplayerEntered [body.playerIndex] = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player and !isDone : 
		body.press_action.disconnect(_on_action_pressed)
		ListplayerEntered [body.playerIndex] = false


func _on_action_pressed(playerIndex: int,player: Player ) -> void: 
	
	if(!isDone):
		var rand : int = randi_range(0,99)
		if( rand >= probaSuccess ) :
			moveDoorAnimation.play("TryFail")
			global_position = ListPosition[indexPosition]
			indexPosition = (indexPosition +1 )%( nbIndexPosition -1)
		else :
			 
			moveDoorAnimation.play("TrySucceed")
			
			var allPlayer = player.get_parent().get_children()
			for p in allPlayer :
				if ( ListplayerEntered [p.playerIndex]):
					p.press_action.disconnect(_on_action_pressed)
					ListplayerEntered [p.playerIndex] = false
			isDone=true
