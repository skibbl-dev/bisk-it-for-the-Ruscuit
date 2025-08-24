extends Node2D

const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")

func _ready() -> void:
	Conductor.set_song(MISTA_GREEN_ROUGH_START, 81)
	#Conductor.set_song(MISTA_GREEN_ROUGH_START, 162)
	Conductor.play()
	Conductor.connect("finished", _loop)
# 48.77
# 1234 1234sa 1
func _loop():
	Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 81)
	#Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 162)
	Conductor.play()
