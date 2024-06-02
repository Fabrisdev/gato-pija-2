extends CanvasLayer
var played_animation_backwards_at_start = false
var transition_to_show = 2

func change_scene(target: String) -> void:
	if transition_to_show > 3: transition_to_show = 1
	if transition_to_show == 1: # Circle growing
		$CircleGrowing.play()
		yield($"CircleGrowing/Animator", "animation_finished")
		get_tree().change_scene(target)
		$CircleGrowing.play_backwards()
	if transition_to_show == 2: # Radial wipe
		$RadialWipe.play()
		yield($"RadialWipe/Animator", "animation_finished")
		get_tree().change_scene(target)
		$RadialWipe.play_backwards()
		yield($"RadialWipe/Animator", "animation_finished")
		$RadialWipe.visible = false
	if transition_to_show == 3: # Rect growing
		$RectGrowing.play()
		yield($"RectGrowing/Animator", "animation_finished")
		get_tree().change_scene(target)
		$RectGrowing.play_backwards()
	transition_to_show += 1
	
func play_backwards() -> void:
	if played_animation_backwards_at_start: return
	$CircleGrowing.play_backwards()
	played_animation_backwards_at_start = true

