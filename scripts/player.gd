extends CharacterBody2D

@export_category("Move Variables")
@export var accel:float = 60
@export var max_speed:float = 126
@export var decel:float = 0.83

@export var dash_time:float = 1.7
#@export var dash_distance:float = 180
@export var dash_speed:float = 255
#@export var dash_cooldown:float = 0.6

@export_category("Rhythm Variables")
@export var input_window:float = 0.285
@export var input_offset:float = 0.02
@export var hit_cooldown:float = 1
var last_hit = -2

@export_category("Sprite Variables")
@export var sprite_stretch:float = 0.4
@export var sprite_rotation_weight:float = 0.45
@export var sprite_scale_weight:float = 0.33

@onready var sprite: Sprite2D = $Sprite
@onready var weapon_pivot: Node2D = $WeaponPivot

@onready var attack_animation_player: AnimationPlayer = $WeaponPivot/AttackAnimationPlayer

@onready var dash_timer: ConductedTimer = $DashTimer
var dashing:bool = false
#var last_dash_beat:int
#var dash_direction:Vector2
#var dash_speed:float

var FRAME_RATE:float
#var acted_this_beat:bool = false
var last_acted_beat:int = -2

func _ready() -> void:
	#$PulsePlayer.play("pulse")
	FRAME_RATE = Engine.get_physics_ticks_per_second()
	dash_timer.wait_beats = dash_time
	#Conductor.beat.connect(_beat)
#
#func _beat(_beat):
	#acted_this_beat = false

func _physics_process(delta: float) -> void:
	_rotate_weapon()
	
	var input = Input.get_vector("left", "right", "up", "down")
	
	if(dashing):
		#position += dash_direction*dash_speed*FRAME_RATE*delta
		sprite.modulate = Color(1.3,1.3,1.3)
		velocity = input*dash_speed
		move_and_slide()
		_bend_sprite(input.angle(),1.8)
		
		if(Input.is_action_just_pressed("dash")):
			dashing = false
		
		if(Input.is_action_just_pressed("parry") and abs((Conductor.current_beat+(input_offset*Conductor.beat_per_sec)) - round(Conductor.current_beat+(input_offset*Conductor.beat_per_sec))) <= input_window ):
			dashing = false
			#acted_this_beat = false
		else:
			return
	
	sprite.modulate = Color(1,1,1)
	
	_dash()
	_parry()
	
	#if(Conductor.current_beat - round(Conductor.current_beat) > input_window ):
		#acted_this_beat = false
	
	_move(input, delta)

func _move(input, delta):
	if(input != Vector2.ZERO):
		#velocity = velocity.move_toward(input*max_speed*Conductor.beat_per_sec,accel*delta*FRAME_RATE*Conductor.beat_per_sec)
		#_bend_sprite(velocity.angle(), velocity.length() / (max_speed*Conductor.beat_per_sec))
		velocity = velocity.move_toward(input*max_speed,accel*delta*FRAME_RATE)
		_bend_sprite(velocity.angle(), velocity.length() / max_speed)
	else:
		velocity *= decel*delta
		_bend_sprite(sprite.rotation,0)
	
	move_and_slide()

func _dash():
	if (Input.is_action_just_pressed("dash") # and (round(Conductor.current_beat) - last_dash_beat) >= (dash_time + dash_cooldown)
	and last_acted_beat != round(Conductor.current_beat)
	and abs((Conductor.current_beat+(input_offset*Conductor.beat_per_sec)) - round(Conductor.current_beat+(input_offset*Conductor.beat_per_sec))) <= input_window ):
		#position += position.direction_to(get_global_mouse_position())*dash_distance
		dashing = true
		#dash_direction = position.direction_to(get_global_mouse_position())
		var new_dash_time = dash_time - (Conductor.current_beat - round(Conductor.current_beat))
		dash_timer.start(new_dash_time)
		#dash_speed = (dash_distance/(new_dash_time*Conductor.sec_per_beat))
		#print( (dash_distance/(dash_time*Conductor.sec_per_beat)) )
		#last_dash_beat = round(Conductor.current_beat)
		last_acted_beat = round(Conductor.current_beat)
		#acted_this_beat = true

func _parry():
	if (Input.is_action_just_pressed("parry")
	and last_acted_beat != round(Conductor.current_beat)
	and abs((Conductor.current_beat+(input_offset*Conductor.beat_per_sec)) - round(Conductor.current_beat+(input_offset*Conductor.beat_per_sec))) <= input_window ):
		attack_animation_player.play("attack")
		last_acted_beat = round(Conductor.current_beat)
		#acted_this_beat = true

func _rotate_weapon():
	#weapon_pivot.rotation = Vector2.ZERO.angle_to(mouse_pos)
	weapon_pivot.rotation = get_angle_to(get_global_mouse_position())

func _bend_sprite(direction:float,amount:float):
	sprite.rotation = lerp_angle(sprite.rotation, direction, sprite_rotation_weight)
	
	sprite.scale.x = lerpf(sprite.scale.x, 1+(amount*sprite_stretch), sprite_scale_weight)

func _on_dash_timer_timeout() -> void:
	dashing = false
	#acted_this_beat = false

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	if(dashing):
		return
	if( ((Conductor.current_beat) - last_hit) < hit_cooldown ):
		return
	last_hit = Conductor.current_beat
	if sprite.frame == 3:
		pass
	else:
		sprite.frame+=1
	_area.queue_free()
