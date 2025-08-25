extends Area2D

@export var speed:float = 60
@export var hittable:bool = false
@export var deflectable:bool = false

@onready var FRAME_RATE:float = Engine.get_physics_ticks_per_second()

func _ready() -> void:
	for child in get_children():
		if (child is Sprite2D):
			child.global_rotation = -global_rotation
			

func init_masks():
	if(hittable):
		set_collision_mask_value(3,true)

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT.rotated(rotation))*speed*delta

func _on_area_entered(area: Area2D) -> void:
	#if(_area.is_in_group("player_attack")): # hit by attack
	if(area.get_collision_layer_value(3)):
		if(hittable):
			if(deflectable):
				#rotation_degrees += 180
				#rotation = global_position.angle_to(area.global_position) + deg_to_rad(180)
				rotation = area.get_parent().rotation
			else:
				get_parent().check_children()
				queue_free()
			
			return
		
	get_parent().check_children()
	queue_free()

#func hit():
	#get_parent().check_children()
	#queue_free()

func kill():
	get_parent().check_children()
	queue_free()
