extends Node2D
func _ready():
	$Oro.play("Idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		$Oro.play("Recolectada")
		GameManager.monedas_recolectadas(1)
		GameManager.score += 100
	$Timer.start()

func _on_timer_timeout():
	queue_free()
