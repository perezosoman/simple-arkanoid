extends Node

signal score_changed(new_score: int)
signal lives_changed(new_lives: int)

var score: int = 0:
	set(value):
		score = value
		score_changed.emit(score)

var lives: int = 5:
	set(value):
		lives = value
		lives_changed.emit(lives)
