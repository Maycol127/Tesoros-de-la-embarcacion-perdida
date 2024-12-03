extends Area2D

@onready var anim := $Animated_Chest
@onready var timer := $Timer
signal cofre_abierto

# Variable para saber si el jugador está cerca del cofre
var player_nearby = false
# El cofre fue abierto
var abierto = false

# Función que se ejecuta cuando el jugador entra en el área del cofre
func _on_body_entered(body):
	if body is Player:
		player_nearby = true
	
# Función que se ejecuta cuando el jugador sale del área del cofre
func _on_body_exited(body):
		if body is Player:
			player_nearby = false

# Reproduce la animación de desbloqueo
func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("Desbloqueado") and not abierto:
		anim.play("Desbloqueo") 
		timer.start(1)
		abierto = true #Marca el cofre como abierto

func _on_timer_timeout():
	emit_signal("cofre_abierto")
	anim.stop()
	anim.frame = 5
