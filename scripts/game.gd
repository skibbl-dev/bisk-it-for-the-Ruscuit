class_name Game
extends Node2D

const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")

@onready var bullet_container: Node2D = $BulletContainer
@onready var enemy_spawner: Node2D = $EnemySpawner

static var INSTANCE

func _ready() -> void:
	Game.INSTANCE = self
	$PulsePlayer.play("pulse")
	#Conductor.set_song(MISTA_GREEN_ROUGH_START, 81)
	#Conductor.set_song(MISTA_GREEN_ROUGH_START, 162)
	#Conductor.play()
	Conductor.connect("finished", _loop)
	enemy_spawner.spawn_next_wave()

func _loop():
	#Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 81)
	Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 162)
	Conductor.play()

func enemy_died():
	if(enemy_spawner.current_wave.get_children().size() <= 1):
		enemy_spawner.spawn_next_wave()
