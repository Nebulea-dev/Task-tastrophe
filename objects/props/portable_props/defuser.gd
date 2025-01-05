extends PortableProps

class_name Defuser


@export var bomb_id:int 



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NumberLabel.text = "%d" % bomb_id
	readyHook()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
