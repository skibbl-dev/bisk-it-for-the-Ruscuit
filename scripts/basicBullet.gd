extends Area2D

@export var speed:float = 60
@export var deflectable:bool = false

@export var normal_color:Color = Color(0.722, 0.525, 0.525)
@export var deflectable_color:Color = Color(0.62, 0.553, 0.694)
@export_range(0,1,0.1) var chance_for_deflectable:float = 0.3

@onready var FRAME_RATE:float = Engine.get_physics_ticks_per_second()

func _ready() -> void:
	if(randf()<=chance_for_deflectable):
		modulate = deflectable_color
		deflectable = true
	for child in get_children():
		if (child is Sprite2D):
			child.global_rotation = -global_rotation
	

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT.rotated(rotation))*speed*delta

func _on_area_entered(area: Area2D) -> void:
	#if(_area.is_in_group("player_attack")): # hit by attack
	if(area.get_collision_layer_value(3)):
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
