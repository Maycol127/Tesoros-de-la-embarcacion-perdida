extends CharacterBody2D

class_name Player

var speed := 120
var direccion := 0.0
var jump := 250
const gravity := 9
var dead: bool = false
var espada : bool = false
var salto_count := 0  # Variable para contar los saltos
var cont := 1 #Detectar salto

@onready var anim := $Principal
@export var attacking = false
@export var lanzar_espada = false
#Vida
var max_health = 3
var health = 0
var can_take_damage = true

func _ready():
	health = max_health
	GameManager.player = self

func actualizar_espada():
	espada = true
	
func _process(_delta):
	if Input.is_action_just_pressed("attack") and espada:
		attack()
	if Input.is_action_just_pressed("Lanzar") and espada:
		lanzar()

func _physics_process(_delta):
	direccion = Input.get_axis("left", "right")
	velocity.x = direccion * speed
	if !attacking:
		# Cambia la animación en función de si el personaje está corriendo o en reposo
		match is_on_floor():
			true:
				if direccion != 0:
					anim.play("Run_S" if espada else "Run_NS")
				else:
					anim.play("Idle_S" if espada else "Idle_NS")
				salto_count = 0  # Resetea el contador de saltos al tocar el suelo

	# Inicia el salto (permite hasta dos saltos)
		if Input.is_action_just_pressed("jump") and salto_count < 2:
			velocity.y = -jump  # Salta
			salto_count += 1  # Aumenta el contador de saltos
			anim.play("Jump_S" if espada else "Jump_NS")  # Reproduce la animación de salto

	# Cambia la animación en función de si el personaje está en el aire y cayendo
		if !is_on_floor():
			if velocity.y < 0:
				anim.play("Jump_S" if espada else "Jump_NS")  # Reproduce la animación de salto (cuando sube)
			elif velocity.y > 0:
				anim.play("Fall_S" if espada else "Fall_NS")  # Reproduce la animación de caída (cuando baja)
		else:
			cont = 1
	# Aplicar gravedad si no está en el suelo
	if !is_on_floor():
		velocity.y += gravity
	# Dirección del ataque
	if Input.is_action_just_pressed("left") and espada:
		$Sword.positionX(true)
	if Input.is_action_just_pressed("right") and espada:
		$Sword.positionX(false)
		
	# Actualiza la dirección de la animación
	anim.flip_h = direccion < 0 if direccion != 0 else anim.flip_h
	move_and_slide() 
	

func lanzar():
	if attacking:
		return
	anim.play("Attack_lanzar")
	#Estado de la espada
	attacking = true
	$Sword.visible = false
	espada = false
	#Lanzamiento de espada
	await get_tree().create_timer(0.3).timeout
	$Sword.lanzar()
	attacking = false
#Ataque
func attack():
	if attacking:
		return
	if is_on_floor():
		cont = 1  # Reinicia el contador de ataques en el aire
		anim.play("Attack_normal")
	else:
		if cont <= 0:
			return  # Si ya atacaste en el aire, no puedes atacar de nuevo
		cont -= 1  # Reduce cont, indicando que ya usaste el ataque en el aire
		anim.play("Attack_aire")
	#Lógica del ataque
	var overlapping_objects = $Sword/Area2D.get_overlapping_areas()
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemigo") or area.get_parent().is_in_group("Objetos"):
			area.get_parent().take_damage(1)
	#Animación de ataque
	attacking = true
	await get_tree().create_timer(0.4).timeout
	attacking = false

#Vida
func take_damage(damage_cantidad: int):
	if can_take_damage:
		iframes()
		health -= damage_cantidad
	if health <= 0:
		die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

#Respawn
func die():
	GameManager.respawn_player()
