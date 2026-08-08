extends TextureRect
class_name Card

@export var data: CardData

var front_texture: Texture2D
var back_texture: Texture2D

var hovered := false
var flipped := false

var dragging := false
var drag_offset := Vector2.ZERO
var press_pos := Vector2.ZERO
var scale_tween: Tween

const CLICK_SLOP := 6.0

const DRAG_ACTION: StringName = &"ClickL"


signal just_flipped

@onready var tween = create_tween()
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP  # required for mouse_entered / _gui_input
	resized.connect(_update_pivot)
	_update_pivot()

	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_unhover)

	if data:
		load_card(data)
	show_back()


func _update_pivot() -> void:
	pivot_offset = size * 0.5


# --- input -------------------------------------------------------------

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed(DRAG_ACTION):
		dragging = true
		press_pos = get_global_mouse_position()
		drag_offset = global_position - press_pos
		move_to_front()
		accept_event()


# _input catches the motion/release when the cursor outruns the card.
func _input(event: InputEvent) -> void:
	if not dragging:
		return

	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + drag_offset

	elif event.is_action_released(DRAG_ACTION):
		dragging = false
		# Barely moved? Treat it as a click, not a drag.
		if get_global_mouse_position().distance_to(press_pos) < CLICK_SLOP:
			flip()


# --- card state --------------------------------------------------------

func load_card(cd: CardData) -> void:
	data = cd
	front_texture = cd.frontTexture
	back_texture = cd.backTexture


func show_back() -> void:
	flipped = false
	texture = back_texture


func show_front() -> void:
	flipped = true
	texture = front_texture


func flip() -> void:
	flipped = not flipped
	texture = front_texture if flipped else back_texture


# --- hover -------------------------------------------------------------

func _on_hover() -> void:
	hovered = true
	_tween_scale(Vector2(1.2, 1.2), 0.2)


func _on_unhover() -> void:
	hovered = false
	_tween_scale(Vector2.ONE, 0.2)


func _tween_scale(target: Vector2, time: float) -> void:
	if scale_tween and scale_tween.is_running():
		scale_tween.kill()  # otherwise fast hover in/out stacks conflicting tweens
	scale_tween = create_tween()
	scale_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, "scale", target, time)
