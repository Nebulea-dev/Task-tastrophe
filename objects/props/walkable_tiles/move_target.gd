extends Node2D

class_name MoveTarget

signal target_finished (player: Player)

@onready var moveTargetAnimation = $AnimationPlayer

var usable : bool = false
var playerActiveId: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func open_target(id: int) -> void:
	usable = true
	playerActiveId = id
	moveTargetAnimation.play("Open")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if usable:
		if body is Player:
			if body.playerIndex == playerActiveId:
				usable = false
				target_finished.emit(body)
				moveTargetAnimation.stop()
				
