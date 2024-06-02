extends AnimationPlayer

func _process(delta):
	var animation = get_animation("animation")
	
	var new_rect_size = Vector2(4181, OS.get_window_size().length())
	animation.track_set_key_value(0, 1, new_rect_size)
