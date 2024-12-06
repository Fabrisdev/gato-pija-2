extends Node2D

signal go_back

func _on_ViewContainer_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("go_back")


func _on_MarginContainer_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print('xd')
		emit_signal("go_back")
		$"%AnimationPlayer".play("Fade")


func _on_CenterContainer_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("go_back")
