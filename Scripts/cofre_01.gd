extends Area2D

@onready var espada := $Sword
@onready var anim   := $Sword/Espada
var abierto = false

signal jugador 

func _on_cofre_abierto():
	if not espada.visible and not abierto:
		espada.visible = true
		anim.play("Idle")
		abierto = true
		await get_tree().create_timer(0.4).timeout
