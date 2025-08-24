extends CharacterBody2D

@export_category("Move Variables")
@export var accel:float = 40
@export var max_speed:float = 110
@export var decel:float = 0.9

@export_category("Sprite Variables")
@export var sprite_stretch:float = 0.4
@export var sprite_rotation_weight:float = 0.45
@export var sprite_scale_weight:float = 0.25

@onready var sprite: Sprite2D = $Sprite
@onready var weapon_pivot: Node2D = $WeaponPivot

var FRAME_RATE:float

func _ready() -> void:
	FRAME_RATE = Engine.get_physics_ticks_per_second()

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	
	_move(input, delta)
	
	_rotate_weapon()

func _move(input, delta):
	if(input != Vector2.ZERO):
		velocity = velocity.move_toward(input*max_speed,accel*delta*FRAME_RATE)
		_bend_sprite(velocity.angle(),velocity.length()/max_speed)
	else:
		velocity *= decel
		_bend_sprite(sprite.rotation,0)
	
	move_and_slide()

func _rotate_weapon():
	#weapon_pivot.rotation = Vector2.ZERO.angle_to(mouse_pos)
	weapon_pivot.rotation = get_angle_to(get_global_mouse_position())

func _bend_sprite(direction:float,amount:float):
	sprite.rotation = lerpf(sprite.rotation, direction, sprite_rotation_weight)
	sprite.scale.x = lerpf(sprite.scale.x, 1+(amount*sprite_stretch), sprite_scale_weight)
