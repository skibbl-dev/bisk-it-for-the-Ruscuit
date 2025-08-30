extends Node2D

func _ready() -> void:
	for child in get_children():
		child.reparent(Game.INSTANCE.bullet_container)
	queue_free()
