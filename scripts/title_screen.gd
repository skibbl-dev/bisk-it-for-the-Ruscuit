extends Control

const ANOTHER_TIME_PERHAPS = preload("res://assets/music/Another Time Perhaps.mp3")

@onready var conducted_player: ConductedAnimationPlayer = $ConductedAnimationPlayer

func _ready() -> void:
	Conductor.set_song(ANOTHER_TIME_PERHAPS, 187)
	Conductor.play()
	conducted_player.play("pulsing")
