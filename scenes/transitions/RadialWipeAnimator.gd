extends AnimationPlayer

const circle_size = 512

func _process(delta):
	var max_size = ceil(OS.get_window_size().length())
	var max_scale = max_size / circle_size
	$"%CircleSprite".rect_scale = Vector2(max_scale, max_scale)

