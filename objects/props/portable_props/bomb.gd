extends PortableProps

class_name Bomb

signal tryFinishMission()

@export var bomb_id:int 

func _ready() -> void:
	$NumberLabel.text = "%d" % bomb_id
	readyHook()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body is Defuser and body.bomb_id == bomb_id:
		Signals.bomb_defused.emit()
		tryFinishMission.emit()
		print(tryFinishMission.get_connections())
		queue_free()
