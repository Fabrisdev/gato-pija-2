extends Node2D

func set_night():
	set_modulate(Color(0.8, 0.8, 0.8))
	$WorldEnvironment.set_night()


func set_day():
	set_modulate(Color(1, 1, 1))
	$WorldEnvironment.set_day()
