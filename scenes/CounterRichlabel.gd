extends RichTextLabel

func _ready():
	bbcode_text = "[center]00:00"

var seconds := 0
var minutes := 0

func update_text():
	var time_text := ""
	var minutes_text := ""
	var seconds_text := ""
	minutes_text = str(minutes)
	if minutes < 10:
		minutes_text = "0" + str(minutes)
	seconds_text = str(seconds)
	if seconds < 10:
		seconds_text = "0" + str(seconds)
	bbcode_text = "[center]" + minutes_text + ":" + seconds_text

func _on_Timer_timeout():
	seconds += 1
	if seconds > 59:
		seconds = 0
		minutes += 1
	update_text()
	
