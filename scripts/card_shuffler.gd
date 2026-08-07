extends Area2D

signal card_action(flipped: bool)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("ClickL"):
		card_action.emit(true)
	if event.is_action_pressed("ClickR"):
		card_action.emit(false)
	pass
	
