extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("go to main menu"):
		SceneTransition.change_scene("res://scenes/MainMenu.tscn")


func _on_SkillWheel_skill_menu_opened():
	set_modulate(Color(0.8, 0.8, 0.8))


func _on_SkillWheel_skill_menu_closed():
	set_modulate(Color(1, 1, 1))


func _on_Player_died():
	if Input.is_action_just_pressed("retry"):
		var current_scene = get_tree().current_scene.filename
		SceneTransition.change_scene(current_scene)
