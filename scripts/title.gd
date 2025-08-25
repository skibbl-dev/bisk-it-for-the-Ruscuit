extends Control

const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")


@onready var conducted_player: ConductedAnimationPlayer = $ConductedAnimationPlayer

func _ready() -> void:
	Conductor.set_song(MISTA_GREEN_ROUGH_START, 81)#162)
	Conductor.play()
	Conductor.connect("finished", _loop)
	conducted_player.play("pulsing") 

func _loop():
	Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 81)
	Conductor.play()
