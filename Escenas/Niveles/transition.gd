extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var anim = $AnimationPlayer

func _ready():
	color_rect.visible = false
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "black":
		on_transition_finished.emit()
		anim.play("normal")
	elif anim_name == "normal":
		color_rect.visible = false

func transition():
	color_rect.visible = true
	anim.play("black")
