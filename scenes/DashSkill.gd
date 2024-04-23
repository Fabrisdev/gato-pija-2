extends Node2D
signal skill_equipped
var is_joystick_input_allowed = true

func _on_SkillWheel_skill_menu_opened():
	$Animator.play("appear")
	is_joystick_input_allowed = true

func _on_SkillWheel_skill_menu_closed():
	$Animator.play_backwards("appear")
	is_joystick_input_allowed = false

func _on_Animator_skill_equipped():
	emit_signal("skill_equipped")

func _process(delta):
	if not is_joystick_input_allowed: return
	if Input.is_action_just_pressed("select up joystick"):
		$Animator.play("hover")
	if Input.is_action_just_released("select up joystick"):
		if $Animator.current_animation != "appear":
			$Animator.play_backwards("hover")
	if Input.is_action_just_pressed("jump") and Input.is_action_pressed("select up joystick"):
		$EquipSkillAudioPlayer.play()
		$Animator.play("equip")
		yield($Animator, "animation_finished")
		$Animator.play_backwards("appear")
		emit_signal("skill_equipped")
