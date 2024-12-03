extends Node
class_name checkpoint

@export var spawnpoint = false
@export var win_condition = false
var activated = false

func _ready():
	if spawnpoint:
		activo()

func activo():
	if win_condition:
		GameManager.win()
	
	GameManager.checkpoint_actual = self
	activated = true
	$Bandera.play("Activado")


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activo()
