extends Sprite2D

func _on_area_2d_card_action(flipped: bool) -> void:
	if flipped:
		flipped = false
		print(true)
	else:
		flipped = true
		print(false)
	pass # Replace with function body.
