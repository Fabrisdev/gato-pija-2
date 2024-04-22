extends Node2D

signal skill_equipped

func _on_Animator_skill_equipped():
	emit_signal("skill_equipped")
