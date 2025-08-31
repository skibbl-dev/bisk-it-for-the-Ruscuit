extends Node2D

#Array 1 will contain all scenese that can spawn for wave 1
@export var enemy_waves:Array[Array]
@export var wave_streams:Array[AudioStream]
@export var wave_bpms:Array[float]
var wave:int = 0
var current_wave: Node2D
#@onready var wave_label: Label = $WaveLabel

func spawn_next_wave():
	var wave_to_use = wave
	if(!enemy_waves.size()>wave):
		wave_to_use = wave_streams.size()-1
		# Just replay last wave
		#return # IF TEHRE ARE NO MORE WAVES, JUST GIVE UP>
	
	if(current_wave != null):
		current_wave.queue_free()
	var old_stream:AudioStream = Conductor.stream
	Conductor.set_song(wave_streams[wave_to_use], wave_bpms[wave_to_use])
	if(old_stream != Conductor.stream):
		Conductor.play()
	var new_wave = enemy_waves[wave_to_use].pick_random().instantiate()
	call_deferred("add_child", new_wave)
	#add_child(new_wave)
	current_wave = new_wave
	wave += 1
	#wave_label.text = str(wave)
