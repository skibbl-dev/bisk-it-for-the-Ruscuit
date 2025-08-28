extends Node2D

#Array 1 will contain all scenese that can spawn for wave 1
@export var enemy_waves:Array[Array]
var wave:int = 0
var current_wave: Node2D
#@onready var wave_label: Label = $WaveLabel

func spawn_next_wave():
	if(!enemy_waves.size()>wave):
		return # IF TEHRE ARE NO MORE WAVES, JUST GIVE UP>
	
	if(current_wave != null):
		current_wave.queue_free()
	for child in Game.INSTANCE.bullet_container.get_children():
		child.queue_free()
	var new_wave = enemy_waves[wave].pick_random().instantiate()
	call_deferred("add_child", new_wave)
	#add_child(new_wave)
	current_wave = new_wave
	wave += 1
	#wave_label.text = str(wave)
