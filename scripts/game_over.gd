extends Control
class_name GameOver

signal exit_game
signal repeat_level

func _on_repeat_pressed() -> void:
	repeat_level.emit()	


func _on_exit_pressed() -> void:
	exit_game.emit()
