extends Node

@export var inputManagerNode: Node

var res_fixedProps = preload("res://objects/FixedProps/FixedProps.tscn")

var nb_Props: int = 2
var positionProps:Array = [Vector2(100, 000) ,Vector2(250,200)]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for id in range(nb_Props):
		var props = res_fixedProps.instantiate()
		
		props.set_global_position(positionProps[id])
		
		call_deferred("add_child", props)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
