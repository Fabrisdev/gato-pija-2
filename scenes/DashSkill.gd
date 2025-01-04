extends Node2D
signal skill_equipped
var is_joystick_input_allowed = false
var selected = false

func _on_SkillWheel_skill_menu_opened():
	$Animator.play("appear")
	yield($Animator, "animation_finished")
	is_joystick_input_allowed = true

func _on_SkillWheel_skill_menu_closed():
	$Animator.play_backwards("appear")
	is_joystick_input_allowed = false

func _on_Animator_skill_equipped():
	emit_signal("skill_equipped")

func _process(delta):
	if not is_joystick_input_allowed: return
	if Input.is_action_pressed("select up joystick"):
		handle_hover()
	if not Input.is_action_pressed("select up joystick") or Input.is_action_pressed("select left joystick"):
		handle_dehover()
	if Input.is_action_just_pressed("jump"):
		handle_equip()

func handle_hover():
	if Input.is_action_pressed("select left joystick"): return
	if selected: return
	selected = true
	$Animator.play("hover")
	$HoverSkillAudioPlayer.play()

func handle_dehover():
	if not selected: return
	selected = false
	if $Animator.current_animation != "appear":
		$Animator.play_backwards("hover")

func handle_equip():
	if not selected: return
	selected = false
	is_joystick_input_allowed = false
	$EquipSkillAudioPlayer.play()
	$Animator.play("equip")
	yield($Animator, "animation_finished")
	$Animator.play_backwards("appear")
	emit_signal("skill_equipped")
