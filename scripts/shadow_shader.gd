extends CanvasLayer

@export var base_color:Color
@export var shadow_color:Color
@export var shadow_offset:Vector2i = Vector2i(1,1)

@onready var color_rect: ColorRect = $ColorRect
@onready var shader: ShaderMaterial = $ColorRect.get_material()

func _ready() -> void:
	RenderingServer.set_default_clear_color(base_color)
	shader.set_shader_parameter("base_color", base_color)
	shader.set_shader_parameter("shadow_color", shadow_color)
	shader.set_shader_parameter("shadow_offset", shadow_offset)
	shader.set_shader_parameter("viewport_size", get_viewport().get_visible_rect().size)
	color_rect.size = get_viewport().get_visible_rect().size

func _change_settings(_base_color:Color, _shadow_color:Color, _shadow_offset:Vector2i):
	base_color = _base_color
	shadow_color = _shadow_color
	_shadow_offset = _shadow_offset
	shader.set_shader_parameter("base_color", base_color)
	shader.set_shader_parameter("shadow_color", shadow_color)
	shader.set_shader_parameter("shadow_offset", shadow_offset)
