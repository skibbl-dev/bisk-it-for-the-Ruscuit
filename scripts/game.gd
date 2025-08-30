class_name Game
extends Node2D

# 162
const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")

# 95 or 190
const RUMBLE_AT_THE_GATES = preload("res://assets/music/Rumble at the Gates.ogg")

# 170
const BLACKOUT = preload("res://assets/music/Blackout.wav")

@onready var bullet_container: Node2D = $BulletContainer
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var wave_transition: AnimationPlayer = $WaveTransition

@onready var wave_label: Label = $WaveTransition/RunIndicators/Label

@onready var player: CharacterBody2D = $Player

static var INSTANCE

func _ready() -> void:
	Game.INSTANCE = self
	$PulsePlayer.play("pulse")
	#Conductor.set_song(MISTA_GREEN_ROUGH_START, 162)
	#Conductor.play()
	Conductor.connect("finished", _loop)
	enemy_spawner.spawn_next_wave()

func _loop():
	#Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 162)
	#Conductor.set_song(RUMBLE_AT_THE_GATES, 190)
	#Conductor.set_song(BLACKOUT, 170)
	Conductor.play()

func enemy_died():
	if(enemy_spawner.current_wave.get_children().size() <= 1):
		# instead, we should do an animation
		# then when animation finished spawn spawn_next_wave
		#enemy_spawner.spawn_next_wave()
		wave_transition.play("WaveTransitions")

func update_wave():
	wave_label.text = "Wave : " + str(enemy_spawner.wave+1)

func kill_bullets():
	for child in bullet_container.get_children():
		child.queue_free()
