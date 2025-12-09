extends Node

@export var levels: Array[PackedScene]

# -----------------------------------
@onready var welcome: Welcome = $Welcome
@onready var ui: UI_Points = $UI
@onready var game_over: GameOver = $GameOver
var current_level: LevelBase
var current_level_index: int = 0
var is_game_over := false
# -----------------------------------
func _ready() -> void:
	welcome.visible = true
	ui.visible = false
	game_over.visible = false

# ---------------------------------

func start_game() -> void:
	welcome.visible = false
	ui.visible = true
	game_over.visible = false
	
	current_level_index = 0
	Global.lives = 5
	Global.score = 0
	ui.update_lives()
	load_level()


func load_level() -> void:
	if current_level:
		current_level.queue_free()
		current_level = null
	if current_level_index < levels.size():
		current_level = levels[current_level_index].instantiate()
		current_level.increase_point.connect(_on_level_increase_points)
		current_level.lost_life.connect(_on_level_lost_life)
		current_level.next_level.connect(_on_level_completed)
		add_child(current_level)
	else:
		welcome.visible = true
		game_over.visible = false
		ui.visible = false
		

func show_game_over() -> void:
	welcome.visible = false
	game_over.visible = true
	
# ------------------------------------------------


func _on_end_game() -> void:
	current_level_index = 0
	current_level.queue_free()
	current_level = null
	game_over.visible = true
	welcome.visible = false
	ui.visible = false
	
func _on_level_increase_points() -> void:
	Global.score += 1

func _on_level_lost_life() -> void:
	if is_game_over:
		return
	# Pierde una vida
	if Global.lives > 0:
		Global.lives -= 1
		current_level.start_new_game()
	else:
		# Global.lives = 0
		show_game_over()
	ui.update_lives()
	
func _on_level_completed() -> void:
	current_level_index += 1
	load_level()
	

func _on_welcome_start_game() -> void:
	start_game()


func _on_game_over_exit_game() -> void:
	get_tree().quit(0)


func _on_game_over_repeat_level() -> void:
	is_game_over = false
	start_game()
