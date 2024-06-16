extends Node2D
var menu_opened = false
signal skill_menu_opened
signal skill_menu_closed
signal dash_skill_equipped
var can_open_menu = true

func _process(delta):
	if $"../../Player".skill_on_cooldown: return
	if not can_open_menu: return
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
		$"%WheelP2".visible = true
		$"%WheelP1".visible = true
		$PartsAnimator.play("rotate")
		return
	$CloseWheelAudioPlayer.play()
	close_menu()
	
func close_menu():
	$Animator.play_backwards("wheel")
	$"%WheelEffect".visible = false
	menu_opened = false
	emit_signal("skill_menu_closed")
	$"%WheelP2".visible = false
	$"%WheelP1".visible = false

func _on_DashSkill_skill_equipped():
	close_menu()
	emit_signal("dash_skill_equipped")


func _on_Player_died():
	can_open_menu = false
