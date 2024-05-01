extends CanvasLayer

func play():
	visible = true
	$Animator.play("CoverScreen")
	yield($Animator, "animation_finished")

func play_backwards():
	visible = true
	$Animator.play_backwards("CoverScreen")
	yield($Animator, "animation_finished")
