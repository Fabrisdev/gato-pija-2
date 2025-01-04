extends CanvasLayer

signal dash_skill_equipped
signal double_jump_skill_equipped
signal skill_menu_opened
signal skill_menu_closed

func _on_SkillWheel_dash_skill_equipped():
	emit_signal("dash_skill_equipped")


func _on_SkillWheel_skill_menu_closed():
	emit_signal("skill_menu_closed")


func _on_SkillWheel_skill_menu_opened():
	emit_signal("skill_menu_opened")

func _on_BabyBottle_level_completed():
	$LevelCompletedPopup.show()
	
func set_first_coin_as_obtained():
	$"%UICoin1".set_modulate(Color(1,1,1,1))

func set_second_coin_as_obtained():
	$"%UICoin2".set_modulate(Color(1,1,1,1))
	
func set_third_coin_as_obtained():
	$"%UICoin3".set_modulate(Color(1,1,1,1))


func _on_SkillWheel_double_jump_skill_equipped():
	emit_signal("double_jump_skill_equipped")
