extends PortableProps

class_name Bomb

signal bomb_defused

func _ready() -> void:
	readyHook()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body is Defuser:
		Signals.bomb_defused.emit()
		queue_free()
