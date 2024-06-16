extends Area2D
signal level_completed

func complete_level():
	print("Nivel completado!")
	emit_signal("level_completed")
	queue_free()

func _on_BabyBottle_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("obtain")
