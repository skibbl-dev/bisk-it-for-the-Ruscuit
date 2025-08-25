extends Area2D

@export var speed:float = 60

@onready var FRAME_RATE:float = Engine.get_physics_ticks_per_second()

func _ready() -> void:
	for child in get_children():
		if (child is Sprite2D):
			child.rotation = -rotation

func _physics_process(delta: float) -> void:
	global_position += (Vector2.RIGHT.rotated(rotation))*speed*delta

func _on_area_entered(area: Area2D) -> void:
	queue_free()
