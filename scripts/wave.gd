extends Node2D

@export var margin:Vector2i = Vector2(10,10)

func _ready() -> void:
	
	var randomize_positions = get_node_or_null("RandomizePositions")
	
	if(randomize_positions == null):
		return
	
	var screen_size:Vector2i = Vector2i(get_viewport().get_visible_rect().size)
	for child in randomize_positions.get_children():
		child.reparent(self)
		child.position = Vector2(randi_range(margin.x, screen_size.x-margin.x), randi_range(margin.y, screen_size.y-margin.y))
	randomize_positions.queue_free()
