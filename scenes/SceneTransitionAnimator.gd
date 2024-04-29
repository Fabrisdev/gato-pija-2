extends AnimationPlayer
const circle_size = 512



func _process(delta):
	var animation = get_animation("CoverScreen")
	var max_size = ceil(OS.get_window_size().length())
	var max_scale = max_size / circle_size
	animation.track_set_key_value(0, 1, Vector2(max_scale, max_scale))
