extends Node2D

func _on_bullet_area_entered(area: Area2D) -> void:
	await get_tree().process_frame
	if(get_child_count() == 0):
		queue_free()
