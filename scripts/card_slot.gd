extends Control
class_name CardSlot

var card: Card = null

func is_empty() -> bool:
	return card == null

func center_point() -> Vector2:
	return global_position + size * 0.5

#func place(c: Card) -> void:
	#card = c
#
	#var viewport_center = get_viewport_rect().size * 0.5
	#c.tween_to(viewport_center - c.size * 0.5)

func place(c: Card) -> void:
	await get_tree().process_frame

	print("Slot size:", size)
	print("Card size:", c.size)
	print("Slot center:", center_point())
	c.global_position = center_point() - c.size / 2
