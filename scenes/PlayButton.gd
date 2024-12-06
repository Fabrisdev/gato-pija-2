extends Button

func _pressed():
	#get_tree().change_scene("res://scenes/World.tscn")
	#SceneTransition.change_scene("res://scenes/World.tscn")
	$"%Camera/AnimationPlayer".play("MoveDownToPlay")

