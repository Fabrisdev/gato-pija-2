extends CanvasLayer

func play():
	visible = true
	$Animator.play("CoverScreen")

func play_backwards():
	visible = true
	$Animator.play_backwards("CoverScreen")
