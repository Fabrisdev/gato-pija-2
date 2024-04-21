extends CanvasLayer

func change_scene(target: String) -> void:
	$CircleTexture/AnimationPlayer.play("CoverScreen")
	yield($CircleTexture/AnimationPlayer, "animation_finished")
	get_tree().change_scene(target)
	$CircleTexture/AnimationPlayer.play_backwards("CoverScreen")
	
func play_backwards() -> void:
	$CircleTexture/AnimationPlayer.play_backwards("CoverScreen")
