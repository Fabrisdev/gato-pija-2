extends Node2D
signal skill_equipped
var is_joystick_input_allowed = false
var selected = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$EquipAudio.play()
		$AnimationPlayer.play("equip")
		yield($AnimationPlayer, "animation_finished")
		emit_signal("skill_equipped")

func _on_SkillWheel_skill_menu_opened():
	$AnimationPlayer.play("appear")
	yield($AnimationPlayer, "animation_finished")
	is_joystick_input_allowed = true


func _on_SkillWheel_skill_menu_closed():
	$AnimationPlayer.play_backwards("appear")
	is_joystick_input_allowed = false


func _on_Area2D_mouse_entered():
	if $AnimationPlayer.current_animation != "appear":
		$AnimationPlayer.play("hover")
		$HoverAudio.play()


func _on_Area2D_mouse_exited():
	if $AnimationPlayer.current_animation != "appear":
		$AnimationPlayer.play_backwards("hover")

func _process(delta):
	if not is_joystick_input_allowed: return
	if Input.is_action_pressed("select left joystick") and Input.is_action_pressed("select up joystick") and selected == false:
		$AnimationPlayer.play("hover")
		$HoverAudio.play()
		selected = true
	if Input.is_action_just_released("select left joystick") or Input.is_action_just_released("select up joystick") and selected:
		selected = false
		if $AnimationPlayer.current_animation != "appear":
			$AnimationPlayer.play_backwards("hover")
	if Input.is_action_just_pressed("jump"):
		if not selected: return
		selected = false
		is_joystick_input_allowed = false
		$EquipAudio.play()
		$AnimationPlayer.play("equip")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play_backwards("appear")
		emit_signal("skill_equipped")
