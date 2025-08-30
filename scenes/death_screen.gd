extends Node2D

@onready var sad_music: AudioStreamPlayer = $SAD_MUSIC
@onready var play_again: Label = $play_again

var can_again = false

func _ready() -> void:
	Conductor.stop()
	sad_music.play()
	await get_tree().create_timer(1).timeout
	can_again = true
	play_again.show()


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if can_again == true:
			get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
			Conductor.play()
