extends StaticBody2D

var canon_ball = load("res://Escenas/Enemigos/bola_canon.tscn")
var modelo = load("res://Escenas/Enemigos/canon.tscn")

@export var shooting : bool
var firerate = 2

@onready var animation_player = $AnimationPlayer
@onready var firepoint = $Firepoint

var max_health = 3
var health

func _ready():
	health = max_health
	shooting = true
	shoot()
	
func shoot():
	while shooting:
		$AnimationPlayer.play("Fire")
		await get_tree().create_timer(firerate).timeout

func fire():
	var spawned_ball = canon_ball.instantiate()
	spawned_ball.direccion = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
	
func take_damage(damage_amount):
	health -= damage_amount
	animation_player.play("Hit")
	if health <= 0:
		die()
		
func die():
	var spawned_base = modelo.instantiate()
	spawned_base.global_position = position
	spawned_base.get_child(1).play("Idle")
	get_tree().get_root().get_child(1).add_child(spawned_base)
	queue_free()
	
