extends CanvasLayer

func play():
	visible = true
	$Animator.play("animation")

func play_backwards():
	$Animator.play_backwards("animation")
