extends CanvasLayer

func _on_SkillWheel_skill_menu_opened():
	$Text.modulate = Color(1, 1, 1, 0.5)

func _on_SkillWheel_skill_menu_closed():
	$Text.modulate = Color(1, 1, 1)
