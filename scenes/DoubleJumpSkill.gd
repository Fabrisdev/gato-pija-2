extends Node2D
signal skill_equipped


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$EquipAudio.play()
		$AnimationPlayer.play("equip")
		yield($AnimationPlayer, "animation_finished")
		emit_signal("skill_equipped")

func _on_SkillWheel_skill_menu_opened():
	$AnimationPlayer.play("appear")


func _on_SkillWheel_skill_menu_closed():
	$AnimationPlayer.play_backwards("appear")


func _on_Area2D_mouse_entered():
	if $AnimationPlayer.current_animation != "appear":
		$AnimationPlayer.play("hover")
		$HoverAudio.play()


func _on_Area2D_mouse_exited():
	if $AnimationPlayer.current_animation != "appear":
		$AnimationPlayer.play_backwards("hover")

