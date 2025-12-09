extends Node2D

signal ball_lost
# Cuando se pierde la pelota se emite esta señal y se genera
# una nueva pelota desde el nodo principal.

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		print ("Pelota perdida!!")
		emit_signal("ball_lost")
		body.queue_free()
		# Elimina la pelota que ha caído en la zona de muerte.
		# La nueva pelota se generará desde el nodo principal.
