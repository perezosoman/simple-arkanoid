extends Node
class_name LevelBase

signal next_level
signal lost_life
signal increase_point
@onready var respawn_ball:Marker2D = $Respawn


func _ready() -> void:
	call_deferred("_connect_blocks")

func _connect_blocks() -> void:
	for block in get_tree().get_nodes_in_group("block"):
		if block is Block and block is not UnbreakableBlock:
			(block as Block).block_was_hit.connect(_on_block_block_was_hit)


func start_new_game() -> void:
	var new_ball: Ball = preload("res://scenes/ball.tscn").instantiate()
	var ball_position := respawn_ball.position
	new_ball.position = ball_position
	call_deferred("add_child", new_ball)


func _on_block_block_was_hit() -> void:
	increase_point.emit()
	# Count remaining breakable blocks that are still alive
	var breakable_alive := 0
	for block in get_tree().get_nodes_in_group("block"):
		if block is Block and block is not UnbreakableBlock:
			var b := block as Block
			if not b._is_dead:
				breakable_alive += 1
	if breakable_alive == 0:
		next_level.emit()


# Cuando se pierde la pelota se emite esta señal y se genera
# una nueva pelota desde aqui. 
func _on_background_ball_lost() -> void:
	lost_life.emit()
