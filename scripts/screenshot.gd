extends Node

@export_file() var path
var number=0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('screenshot'):
		take_screenshot()
		number+=1

func take_screenshot() -> void:
	get_viewport().get_texture().get_image().save_png(path+str(number) +".png")
