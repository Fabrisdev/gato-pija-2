extends CanvasLayer
var played_animation_backwards_at_start = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func change_scene(target: String) -> void:
	var transition_chosen = rng.randi_range(1, 2)
	print(transition_chosen)
	if transition_chosen == 1: # Circle growing
		$CircleGrowing.play()
		yield($"CircleGrowing/Animator", "animation_finished")
		get_tree().change_scene(target)
		$CircleGrowing.play_backwards()
	if transition_chosen == 2: # Radial wipe
		$RadialWipe.play()
		yield($"RadialWipe/Animator", "animation_finished")
		get_tree().change_scene(target)
		$RadialWipe.play_backwards()
		yield($"RadialWipe/Animator", "animation_finished")
		$RadialWipe.visible = false
	
func play_backwards() -> void:
	if played_animation_backwards_at_start: return
	$CircleGrowing.play_backwards()
	played_animation_backwards_at_start = true

