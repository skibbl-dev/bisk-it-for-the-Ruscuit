extends Node2D

func _ready() -> void:
	for child in get_children():
		child.reparent(get_tree().get_root().get_child(1))
	queue_free()
