extends AnimationPlayer

signal skill_equipped

func _on_InteractableArea_mouse_entered():
	if current_animation != "appear":
		play("hover")
		$"../HoverSkillAudioPlayer".play()

func _on_InteractableArea_mouse_exited():
	if current_animation != "appear":
		play_backwards("hover")


func _on_InteractableArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$"../EquipSkillAudioPlayer".play()
		play("equip")
		yield(self, "animation_finished")
		play_backwards("appear")
		emit_signal("skill_equipped")
