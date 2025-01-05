extends Node2D

class_name ZoneDetector

signal tryFinishMission(playerId :int)

@export var detector_id:int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Signals.grass_touched.emit(body.playerIndex)
		tryFinishMission.emit(body.playerIndex)
		$GrassSound.play()
