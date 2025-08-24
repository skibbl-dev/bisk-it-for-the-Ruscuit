extends CanvasLayer

@export var base_color:Color
@export var shadow_color:Color

@onready var shader: ShaderMaterial = $ColorRect.get_material()

func _ready() -> void:
	RenderingServer.set_default_clear_color(base_color)
	shader.set_shader_parameter("base_color", base_color)
	shader.set_shader_parameter("shadow_color", shadow_color)
