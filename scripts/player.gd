extends CharacterBody2D

@export var accel:float = 40
@export var max_speed:float = 110
@export var decel:float = 0.9

@onready var sprite: Sprite2D = $Sprite

var FRAME_RATE

func _ready() -> void:
	FRAME_RATE = Engine.get_physics_ticks_per_second()

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	
	if(input != Vector2.ZERO):
		velocity = velocity.move_toward(input*max_speed,accel*delta*FRAME_RATE)
	else:
		velocity *= decel
	
	move_and_slide()
