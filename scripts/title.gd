extends Control

const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")

@onready var conducted_player: ConductedAnimationPlayer = $ConductedAnimationPlayer
@onready var start: Button = $start

var count := 0

func _ready() -> void:
	Conductor.set_song(MISTA_GREEN_ROUGH_START, 81)#162)
	Conductor.play()
	Conductor.connect("finished", _loop)
	conducted_player.play("pulsing") 

func _loop():
	Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 81)
	Conductor.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	count += 1
	if count == 3:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
