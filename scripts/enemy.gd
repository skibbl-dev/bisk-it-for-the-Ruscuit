extends CharacterBody2D

@export var bullets:Array[PackedScene]
#@export var bullet_summon_cooldown:float = 4
@export var health:int = 1

@onready var anim_player: ConductedAnimationPlayer = $ConductedAnimationPlayer

var last_summoned_beat:float = -1

func _ready() -> void:
	anim_player.play("start")

func summon_bullet(bullet:int, beat:float, angle:float=0, offset:Vector2=Vector2(0,0)): ## if angle = -999 face toward player
	
	if(last_summoned_beat == beat):
		return
	
	last_summoned_beat = beat
	var new_bullet:Node2D = bullets[bullet].instantiate()
	new_bullet.rotation_degrees = angle
	new_bullet.global_position = global_position+offset
	get_tree().get_root().get_child(1).add_child(new_bullet)
	
	if(angle == -999):
		new_bullet.rotation = (position+offset).angle_to_point(get_tree().get_first_node_in_group("player").position)

func change_animation(_name:StringName):
	anim_player.play(_name)

func change_animtion_with_chance(_name:StringName, chance:float):
	if(randf() <= chance):
		anim_player.play(_name)

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	health -= 1
	if(health <= 0):
		queue_free()
