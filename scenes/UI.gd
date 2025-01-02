extends CanvasLayer

signal dash_skill_equipped
signal skill_menu_opened
signal skill_menu_closed

func _on_SkillWheel_dash_skill_equipped():
	emit_signal("dash_skill_equipped")


func _on_SkillWheel_skill_menu_closed():
	emit_signal("skill_menu_closed")


func _on_SkillWheel_skill_menu_opened():
	emit_signal("skill_menu_opened")
