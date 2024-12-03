extends Camera2D

func _process(_delta):
	global_position.x = get_parent().global_position.x
