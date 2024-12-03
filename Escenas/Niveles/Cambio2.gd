extends Area2D

func _on_body_entered(body):
	if body.name == "Player":  # Verifica que el objeto sea el jugador
		get_tree().change_scene_to_file("res://Escenas/Niveles/Nivel_02.tscn")
