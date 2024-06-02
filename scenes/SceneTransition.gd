extends CanvasLayer
var played_animation_backwards_at_start = false
enum Transition { 
	CIRCLE_GROWING = 1,
	RADIAL_WIPE = 2,
	RECT_GROWING = 3
}
var transition_to_show = Transition.RADIAL_WIPE

func change_scene(target: String) -> void:
	if transition_to_show > 3: transition_to_show = 1
	if transition_to_show == Transition.CIRCLE_GROWING:
		$CircleGrowing.play()
		yield($"CircleGrowing/Animator", "animation_finished")
		get_tree().change_scene(target)
		$CircleGrowing.play_backwards()
	if transition_to_show == Transition.RADIAL_WIPE:
		$RadialWipe.play()
		yield($"RadialWipe/Animator", "animation_finished")
		get_tree().change_scene(target)
		$RadialWipe.play_backwards()
		yield($"RadialWipe/Animator", "animation_finished")
		$RadialWipe.visible = false
	if transition_to_show == Transition.RECT_GROWING:
		$RectGrowing.play()
		yield($"RectGrowing/Animator", "animation_finished")
		get_tree().change_scene(target)
		$RectGrowing.play_backwards()
	transition_to_show += 1
	
func play_backwards() -> void:
	if played_animation_backwards_at_start: return
	$CircleGrowing.play_backwards()
	played_animation_backwards_at_start = true

