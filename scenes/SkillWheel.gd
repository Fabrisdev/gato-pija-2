extends Node2D
var menu_opened = false
signal skill_menu_opened
signal skill_menu_closed

func _process(delta):
	if not Input.is_action_just_pressed("open skill wheel"):
		return
	if $Animator.is_playing():
		return
	if not menu_opened:
		$OpenWheelAudioPlayer.play()
		$Animator.play("wheel")
		$"%WheelEffect".visible = true
		menu_opened = true
		emit_signal("skill_menu_opened")
		return
	$CloseWheelAudioPlayer.play()
	close_menu()
	
func close_menu():
	$Animator.play_backwards("wheel")
	$"%WheelEffect".visible = false
	menu_opened = false
	emit_signal("skill_menu_closed")

func _on_DashSkill_skill_equipped():
	close_menu()
