extends Node2D

@export var normal_color:Color = Color(1,1,1)
@export var hittable_color:Color = Color(1,1,1)
@export var deflectable_color:Color = Color(1,1,1)
@export_range(0,1,0.1) var chance_for_hittable:float = 0.4
@export_range(0,1,0.1) var chance_for_deflectable:float = 0.8

func _ready() -> void:
	for child:Node2D in get_children():
		child.modulate = normal_color
		if(randf()<=chance_for_hittable):
			child.modulate = hittable_color
			child.hittable = true
			if(randf()<=chance_for_deflectable):
				child.modulate = deflectable_color
				child.deflectable = true
		child.init_masks()

func check_children():
	await get_tree().process_frame
	if(get_child_count() == 0):
		queue_free()
