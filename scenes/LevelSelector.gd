extends Node2D

signal go_back

# FADING CUANDO TE PARAS SOBRE UN COSTADO DE LA PANTALLA

func _on_HoverDetectorBottom_mouse_entered():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("FadeBottom")

func _on_HoverDetectorBottom_mouse_exited():
	$AnimationPlayer.play("RESET")

func _on_HoverDetectorTop_mouse_entered():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("FadeTop")

func _on_HoverDetectorTop_mouse_exited():
	$AnimationPlayer.play("RESET")

func _on_HoverDetectorRight_mouse_entered():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("FadeRight")

func _on_HoverDetectorRight_mouse_exited():
	$AnimationPlayer.play("RESET")

func _on_HoverDetectorLeft_mouse_entered():
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("FadeLeft")

func _on_HoverDetectorLeft_mouse_exited():
	$AnimationPlayer.play("RESET")

# AVISAR QUE SE QUIERE VOLVER ATRAS

func _on_HoverDetectorTop_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("go_back")

func _on_HoverDetectorLeft_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("go_back")

func _on_HoverDetectorRight_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("go_back")

func _on_HoverDetectorBottom_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("go_back")
