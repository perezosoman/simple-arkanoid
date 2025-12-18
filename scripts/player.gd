extends CharacterBody2D

var min_x := 88
var max_x := 633

@onready var target_position: Vector2 = position
@onready var start_position: Vector2 = position

const SPEED := 600
const THRESHOLD := 8


func _physics_process(_delta: float) -> void:
	var direction_x := target_position.x - position.x
	if abs(direction_x) > THRESHOLD:
		direction_x = sign(direction_x)
		velocity = Vector2(direction_x * SPEED,0)
		move_and_slide()
		# Mantener la posicion de Y fija
		position.y = start_position.y
	else: 
		# Detenemos el player al llegar a la posicion objetivo
		velocity = Vector2.ZERO
		position.x = target_position.x
		


func update_target_position(event: InputEventMouse)->void:
	target_position.x = clamp(event.position.x,min_x,max_x)
	target_position.y = 0	


func stop_player(_event:InputEventMouse)->void:
	velocity = Vector2.ZERO
	target_position = position
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			update_target_position(event)
		if event.is_action_released("click"):
			stop_player(event)
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("click"):
			update_target_position(event)
