extends CharacterBody2D
class_name Ball


var direction: Vector2 = Vector2(1, 1)
@export var speed: float = 5

func _physics_process(_delta: float) -> void:
	var collided := move_and_collide(direction * speed * _delta)
	if (collided):
		var normal: Vector2 = collided.get_normal()
		direction = direction.bounce(normal)
		if collided.get_collider() is Block:
			var block: Block = collided.get_collider()
			block.hit()
