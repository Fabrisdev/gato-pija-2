extends Node2D

func _ready():
	SceneTransition.play_backwards()
	$AnimationPlayer.play("TitleColor")
	$AnimationPlayer2.play("TwoTitle")
