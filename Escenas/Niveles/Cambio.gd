extends Area2D

func _on_body_entered(body):
	if body is Player:  # Asegúrate de que el jugador está entrando al área
		body.die()
