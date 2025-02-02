extends CharacterBody2D

var speed = -30.0
var gravity = 9
var facing_right = false
var dead = false
var max_health = 2
var health


func _ready():
	health = max_health
	$Estrella.play("Run")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead:
		area.get_parent().take_damage(1)
		$Estrella.play("Hit")
		await get_tree().create_timer(0.4).timeout
		$Estrella.play("Idle")

func take_damage(damage_amount):
	health -= damage_amount
	if health <= 0:
		die()

func die():
	GameManager.score += 300
	dead = true
	speed = 0
	$Estrella.play("Dead hit")
	await get_tree().create_timer(0.4).timeout
	$Estrella.play("Suelo")
	await get_tree().create_timer(0.4).timeout
	queue_free()
