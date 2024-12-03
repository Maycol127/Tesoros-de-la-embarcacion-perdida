extends Node2D

@onready var espada := $espada
@export var velocidad := Vector2.ZERO  # Velocidad inicial de la espada

func _process(_delta):
	position += velocidad * _delta

func _on_body_entered(body):
	if espada.visible and body is Player:
		espada.visible = false
		body.actualizar_espada()
