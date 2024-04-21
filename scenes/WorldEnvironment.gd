extends WorldEnvironment


func _on_SkillWheel_skill_menu_opened():
	environment.adjustment_brightness = 0.33


func _on_SkillWheel_skill_menu_closed():
	environment.adjustment_brightness = 1
