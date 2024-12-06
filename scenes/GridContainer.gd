extends GridContainer

var LevelButtonScene = preload("res://scenes/LevelButton.tscn")

func _ready():
	for number in range(18):
		var level_button = LevelButtonScene.instance()
		if randf() > 0.5:
			level_button.first_coin_obtained = true
		if randf() > 0.5:
			level_button.second_coin_obtained = true
		if randf() > 0.5:
			level_button.third_coin_obtained = true
		level_button.text = str(number + 1)
		add_child(level_button)
