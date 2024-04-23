extends CanvasLayer
const max_mana = 352

func reduce_mana(amount):
	var consumed_mana = $ConsumedMana.rect_size.x
	if consumed_mana >= 352 or amount > max_mana - consumed_mana: return
	$ConsumedMana.rect_position.x -= amount
	$ConsumedMana.rect_size.x += amount
