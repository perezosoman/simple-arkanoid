extends Block
class_name HardBlock
var hp := 2
@export var color_hit : Color = Color(0.219, 0.485, 0.902, 1.0)
@onready var color_rect : ColorRect = $ColorRect

func _ready() -> void:
	hp = 2

func hit()-> void:
	hp -= 1
	if hp == 1:
		color_rect.color = color_hit
	elif hp == 0:
		super.hit()
		
