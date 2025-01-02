extends Area2D

func complete_level():
	$"%UI/LevelCompletedPopup".show()

func _on_BabyBottle_body_entered(body):
	if body.is_in_group("player"):
		$"../Player".can_die = false
		$AnimationPlayer.play("obtain")
