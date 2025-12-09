extends Node
class_name LevelBase

signal next_level
signal lost_life
signal increase_point


func _ready() -> void:
	call_deferred("_connect_blocks")

func _connect_blocks() -> void:
	var blocks: Array[Node] = get_tree().get_nodes_in_group("block")
	print ("Hay : " + str(blocks.size()) + " bloques")
	for block in blocks:
		if block is Block:
			(block as Block).block_was_hit.connect(_on_block_block_was_hit)


func start_new_game() -> void:
	var new_ball: Ball = preload("res://scenes/ball.tscn").instantiate()
	new_ball.set_deferred("position", Vector2(520, 520))
	call_deferred("add_child", new_ball)


func _on_block_block_was_hit() -> void:
	print ("Bloque golpeado")
	increase_point.emit()
	var blocks: Array[Node] = get_tree().get_nodes_in_group("block")
	var total_blocks := blocks.size()
	print ("Bloques restantes : " +str(total_blocks))
	if total_blocks == 1:
		next_level.emit()


# Cuando se pierde la pelota se emite esta señal y se genera
# una nueva pelota desde aqui. 
func _on_background_ball_lost() -> void:
	lost_life.emit()
