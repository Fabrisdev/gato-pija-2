extends CanvasLayer

func change_scene(target: String) -> void:
	$Animator.play("CoverScreen")
	yield($Animator, "animation_finished")
	get_tree().change_scene(target)
	$Animator.play_backwards("CoverScreen")
	
func play_backwards() -> void:
	$Animator.play_backwards("CoverScreen")
