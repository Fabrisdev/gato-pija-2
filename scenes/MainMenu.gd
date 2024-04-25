extends Node2D

func _ready():
	SceneTransition.play_backwards()
	$AnimationPlayer.play("TitleColor")
	$AnimationPlayer2.play("TwoTitle")

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		SceneTransition.change_scene("res://scenes/World.tscn")
