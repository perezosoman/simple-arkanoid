extends CharacterBody2D
class_name Ball


var direction: Vector2 = Vector2(1, 1)
@export var speed: float = 5

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()
	var collision_count := get_slide_collision_count()
	if collision_count > 0:
		var collision := get_slide_collision(0)
		direction = direction.bounce(collision.get_normal())
		var collider := collision.get_collider()
		if collider is Block:
			(collider as Block).hit()
