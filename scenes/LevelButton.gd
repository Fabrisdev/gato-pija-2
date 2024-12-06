extends Button

export var first_coin_obtained = false
export var second_coin_obtained = false
export var third_coin_obtained = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if first_coin_obtained:
		$FirstCoin.set_modulate(Color(1, 1, 1, 1))
	if second_coin_obtained:
		$SecondCoin.set_modulate(Color(1, 1, 1, 1))
	if third_coin_obtained:
		$ThirdCoin.set_modulate(Color(1, 1, 1, 1))



func _on_LevelButton_mouse_entered():
	if not first_coin_obtained:
		$"FirstCoin/FadeAnimation".play("Fade")
	if not second_coin_obtained:
		$"SecondCoin/FadeAnimation".play("Fade")
	if not third_coin_obtained:
		$"ThirdCoin/FadeAnimation".play("Fade")


func _on_LevelButton_mouse_exited():
	$"FirstCoin/FadeAnimation".play("RESET")
	$"SecondCoin/FadeAnimation".play("RESET")
	$"ThirdCoin/FadeAnimation".play("RESET")
