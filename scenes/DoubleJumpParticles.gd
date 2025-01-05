extends Node2D

func emit():
	$Particles2D.emitting = true
	$Timer.start()

func _on_Timer_timeout():
	$Particles2D.emitting = false
