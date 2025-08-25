extends Node2D

func check_children():
	await get_tree().process_frame
	if(get_child_count() == 0):
		queue_free()
