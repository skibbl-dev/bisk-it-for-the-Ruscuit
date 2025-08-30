extends Control

@onready var cursor: Control = $CursorHolder
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var max_rotation_degrees = 60
@export var max_movement_x = 20
@export var rotation_lerp_weight = 0.6

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	var old_position:float = cursor.global_position.x
	cursor.global_position = get_global_mouse_position()
	cursor.rotation = lerp_angle(cursor.rotation, deg_to_rad(remap((cursor.global_position.x - old_position), -max_movement_x, max_movement_x, -max_rotation_degrees, max_rotation_degrees)), rotation_lerp_weight)
	
	if(Input.is_action_just_pressed("parry")):
		animation_player.play("click")
	
