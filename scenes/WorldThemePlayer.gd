extends Node2D

func play():
	$AudioStreamPlayer.play()
	
func stop():
	$AudioStreamPlayer.stop()

func is_playing():
	return $AudioStreamPlayer.is_playing()
