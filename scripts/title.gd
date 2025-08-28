extends Control

const MISTA_GREEN_ROUGH_START = preload("res://assets/music/mista green rough start.wav")
const MISTA_GREEN_ROUGH_LOOP = preload("res://assets/music/mista green rough loop.wav")

@onready var pulse_player: ConductedAnimationPlayer = $PulsePlayer

@onready var conducted_player: ConductedAnimationPlayer = $ConductedAnimationPlayer
@onready var explosion_sound: AudioStreamPlayer = $START/explosion
@onready var start_particles: GPUParticles2D = $START/StartParticles

@onready var states = [
	$START/dam0,
	$START/dam1,
	$START/dam2,
	$START/dam3
]

var current_state := 0

func _ready() -> void:
	for node in states:
		node.hide()
	set_crack_level(0)
	Conductor.set_song(MISTA_GREEN_ROUGH_START, 162)
	Conductor.play()
	Conductor.connect("finished", _loop)
	conducted_player.play("pulsing")
	pulse_player.play("pulse")
	explosion_sound.volume_db = -40

func _loop():
	Conductor.set_song(MISTA_GREEN_ROUGH_LOOP, 162)
	Conductor.play()

func set_crack_level(level: int) -> void:
	current_state = level
	for i in states.size():
		states[i].visible = (i == level)
	shake()

func _on_start_area_entered(_area: Area2D) -> void:
	if current_state < states.size() - 1:
		start_particles.emitting = true
		set_crack_level(current_state + 1)
		explosion_sound.play()
		explosion_sound.volume_db += 10
	else:
		#get_tree().change_scene_to_file("res://scenes/game.tscn")
		get_tree().call_deferred("change_scene_to_file", "res://scenes/game.tscn")
		# I hope this should work, i was mostly just trying to fix the error/warning in the console
		# I think what should happen is it will wait for the scene to be "ready" before changing scenes? idrk

func shake():
	var tween = create_tween()
	var rand_offset = Vector2(randi_range(-10, 10), randi_range(-10, 10))
	position += rand_offset
	tween.tween_property(self, "position", Vector2.ZERO, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
