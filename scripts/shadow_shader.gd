extends CanvasLayer

@export var base_color:Color
@export var shadow_color:Color

@onready var color_rect: ColorRect = $ColorRect
@onready var shader: ShaderMaterial = $ColorRect.get_material()

func _ready() -> void:
	RenderingServer.set_default_clear_color(base_color)
	shader.set_shader_parameter("base_color", base_color)
	shader.set_shader_parameter("shadow_color", shadow_color)
	shader.set_shader_parameter("viewport_size", get_viewport().get_visible_rect().size)
	color_rect.size = get_viewport().get_visible_rect().size
