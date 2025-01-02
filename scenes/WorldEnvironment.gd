extends WorldEnvironment


func _on_UI_skill_menu_opened():
	environment.adjustment_brightness = 0.33


func _on_UI_skill_menu_closed():
	environment.adjustment_brightness = 1
