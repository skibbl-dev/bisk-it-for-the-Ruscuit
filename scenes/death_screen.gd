extends Node2D

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/game.tscn")
