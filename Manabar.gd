extends CanvasLayer

func reduce_mana(amount):
	if $ConsumedMana.rect_size <= 0: return
	$ConsumedMana.rect_position.x -= 1
	$ConsumedMana.rect_size.x += 1
