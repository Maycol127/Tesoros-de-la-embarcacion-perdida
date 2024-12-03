extends Node2D

@onready var espada := $"."
@export var velocidad := 150.0  # Velocidad inicial de la espada
const gravedad := 7
#var direccion := Vector2.ZERO
var velocidad_y := 0
var lanzada := false
var direccion := 1

func _process(_delta):
	#Lanzar la espada
	if lanzada:
		#Eje x
		global_position.x += direccion * velocidad * _delta
		#Eje y
		velocidad_y += gravedad * _delta
		global_position.y += velocidad_y * _delta
		
		print(espada.global_position.y)
		if $RayCast2D.is_colliding():
			lanzada = false
			velocidad_y = 0
			print("La espada colisionó")
		
func lanzar():
	#direccion = direccion
	lanzada = true
	velocidad_y = 0
	espada.visible = true
	$Espada.play("Lanzado")


func _on_body_entered(body):
	if espada.visible and body is Player:
		espada.visible = false
		lanzada = false
		body.actualizar_espada()

func positionX(girar: bool):
	if girar:
		direccion = -1
	else:
		direccion = 1
