extends RigidBody2D

class_name PortableProps

var portable: bool = true


# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	readyHook()

func readyHook() -> void:
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	$Area2D.body_exited.connect(_on_area_2d_body_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.press_action.connect(_on_action_pressed)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.press_action.disconnect(_on_action_pressed)

func _on_action_pressed(_playerIndex: int, player: Player) -> void:
	player.carry_prop(self)
