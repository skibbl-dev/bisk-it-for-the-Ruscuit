extends Node2D

@onready var sad_music: AudioStreamPlayer = $SAD_MUSIC

var can_again : bool = false

func _ready() -> void:
	Conductor.stop()
	sad_music.play()
	await get_tree().create_timer(2).timeout
	can_again = true


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if can_again == true:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
