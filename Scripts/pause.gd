extends CanvasLayer

@onready var score_label = $WinScreen/Label

func _ready():
	GameManager.pause_menu = $MenuPausa
	GameManager.win_screen = $WinScreen
	GameManager.score_label = $WinScreen/Label

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		GameManager.pause_play()
		get_tree().paused = GameManager.paused

func _on_continuar_pressed():
	GameManager.volver()

func _on_reiniciar_pressed():
	GameManager.reiniciar()
	
func _on_controles_pressed():
	GameManager.controles()

func _on_salir_pressed():
	GameManager.salir()
