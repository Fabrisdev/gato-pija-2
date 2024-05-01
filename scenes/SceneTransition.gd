extends CanvasLayer

func change_scene(target: String) -> void:
	$CircleGrowing.play()
	yield($"CircleGrowing/Animator", "animation_finished")
	get_tree().change_scene(target)
	$CircleGrowing.play_backwards()
	
func play_backwards() -> void:
	$CircleGrowing.play_backwards()

