extends RichTextLabel
var debugEnabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	toggleDebug()
	if debugEnabled:
		showDebug()
	else:
		hide()
func toggleDebug():
	if Input.is_action_just_released("toggle_debug"):
		debugEnabled = !debugEnabled
	
func showDebug():
	show()
	var player = get_node("../../Player")
	var fps = Engine.get_frames_per_second()
	text = "FPS: "+ str(fps) + "\n"
	text += "ACCEL X: "+ str(player.motion.x) + "\n"
	text += "ACCEL Y: "+ str(player.motion.y) + "\n"
	text += "X: "+ str(player.position.x) + "\n"
	text += "Y: "+ str(player.position.y) + "\n"


func _on_Timer_timeout():
	pass # Replace with function body.
