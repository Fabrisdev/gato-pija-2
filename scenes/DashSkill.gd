extends Node2D
signal skill_equipped

func _on_SkillWheel_skill_menu_opened():
	$Animator.play("appear")


func _on_SkillWheel_skill_menu_closed():
	$Animator.play_backwards("appear")


func _on_Animator_skill_equipped():
	emit_signal("skill_equipped")
