extends StaticBody2D
class_name Block

signal block_was_hit

var _is_dead := false

func destroy_me() -> void:
	var tween := create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(0, 0), 0.3)
	tween.parallel().tween_property(self, "modulate:a", 0, 0.3)
	tween.connect("finished", queue_free)

func hit() -> void:
	if _is_dead:
		return
	_is_dead = true
	block_was_hit.emit()
	destroy_me()
