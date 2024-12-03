extends Node2D

@export var speed = 160.0
var velocidad_actual = 0.0

@onready var spawn_pos = global_position

func _physics_process(_delta):
	position.y += velocidad_actual * _delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
		queue_free()
	
func _on_deteccion_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")

func fall():
	velocidad_actual = speed
	await get_tree().create_timer(3).timeout
	position = spawn_pos
	velocidad_actual = 0
