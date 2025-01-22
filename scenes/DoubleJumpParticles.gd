extends Node2D

func emit():
	$CPUParticles2D.emitting = true
	$Timer.start()

func _on_Timer_timeout():
	$CPUParticles2D.emitting = false
