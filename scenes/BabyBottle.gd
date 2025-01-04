extends Area2D
signal level_completed

func _on_BabyBottle_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("obtain")
		emit_signal("level_completed")
