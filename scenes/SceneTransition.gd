extends CanvasLayer

func change_scene(target: String) -> void:
	$"%AnimationPlayer".play("CoverScreen")
	yield($"%AnimationPlayer", "animation_finished")
	get_tree().change_scene(target)
	$"%AnimationPlayer".play_backwards("CoverScreen")
	
func play_backwards() -> void:
	$"%AnimationPlayer".play_backwards("CoverScreen")
