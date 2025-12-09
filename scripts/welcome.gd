extends Control
class_name Welcome

signal start_game

func _on_start_button_pressed() -> void:
	start_game.emit()
