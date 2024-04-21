extends Node

func _process(delta):
	if Input.is_action_just_pressed("toggle_vsync"):
		#OS.vsync_enabled = !OS.vsync_enabled
		#		OS.vsync_enabled = false
		#Engine.set_target_fps()
		pass
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
