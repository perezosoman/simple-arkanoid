extends Control
class_name UI_Points

@onready var container: GridContainer = %GridContainer

func update_score(new_score: int) -> void:
	(%ScorePoints as Label).text = str(new_score)

func update_lives(new_lives: int) -> void:
	var children := container.get_children()
	for i in children.size():
		(children[i] as Control).visible = i < new_lives
