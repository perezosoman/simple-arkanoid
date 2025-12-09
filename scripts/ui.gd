extends Control
class_name UI_Points

@onready var container: GridContainer = %GridContainer
func _process(_delta: float) -> void:
	(%ScorePoints as Label).text = str(Global.score)

	
func update_lives() -> void:
	var childs_count := container.get_child_count()
	var childs := container.get_children() 
	var index := 0
	# Haz visible solo los hijos que corresponden a las vidas restantes
	while (index < Global.lives):
		(childs[index] as Control).visible = true
		index += 1
	# Si hay mas hijos que vidas, oculta los excedentes
	while (index < childs_count):
		(childs[index] as Control).visible = false
		index += 1
