extends Node

signal monedas_contador()

var monedas : int
var score   : int = 0

var checkpoint_actual : checkpoint
var player: Player
var espada: bool = false
var pause_menu
var paused = false
var win_screen
var score_label


func respawn_player():
	player.health = player.max_health
	if checkpoint_actual != null:
		player.position = checkpoint_actual.global_position

func monedas_recolectadas(monedas_agarradas: int):
	monedas += monedas_agarradas
	emit_signal("monedas_contador")
	print(monedas)

func win():
	win_screen.visible = true
	score_label.text = "score:" + str(score)

func pause_play():
	paused = !paused
	pause_menu.visible = paused

func actualizar_espada():
	espada = true

func volver():
	get_tree().paused = false
	pause_play()

func reiniciar():
	monedas = 0
	score = 0
	get_tree().reload_current_scene()
	
func controles():
	pass
func salir():
	get_tree().quit
