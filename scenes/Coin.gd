extends Area2D
signal coin_obtained

func _on_Coin_body_entered(body):
	if body.is_in_group('player'):
		$AnimationPlayer.play("obtain")
		emit_signal("coin_obtained")
