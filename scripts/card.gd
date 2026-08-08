extends TextureRect
class_name Card

@export var data : CardData

var frontTexture : Texture2D
var backTexture : Texture2D

var hovered = false
var flipped = false

func _ready() -> void:
	mouse_entered.connect(hover)
	mouse_exited.connect(unhover)
	loadcard(data)
	flip()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ClickL") and hovered:
		flip()
	if Input.is_action_just_pressed("ClickR") and hovered:
		data.activatePower()

func loadcard(cd : CardData):
	frontTexture = cd.frontTexture
	backTexture = cd.backTexture
	


func flip():
	if not flipped:
		texture = backTexture
	else:
		texture = frontTexture
	
	flipped = not flipped

func hover():
	hovered = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2,1.2), 0.5)

func unhover():
	hovered = false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 0.2)
