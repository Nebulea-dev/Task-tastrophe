extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.bomb_defused.connect(_play_sound_bomb_defused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _play_sound_bomb_defused() -> void:
	$BombDefuseSound.play()
