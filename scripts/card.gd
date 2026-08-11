extends TextureRect
class_name Card

@export var data : CardData

var frontTexture : Texture2D
var backTexture : Texture2D

var hovered = false
var flipped = false

signal just_flipped

@onready var tween = create_tween()
func _ready() -> void:
	#connecting signals to functions
	mouse_entered.connect(hover)
	mouse_exited.connect(unhover)
	
	pivot_offset_ratio = Vector2(0.5,0.5)
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ClickL") and hovered:
		flip()
	if Input.is_action_just_pressed("ClickR") and hovered:
		data.activatePower()

func loadcard(cd : CardData):
	#set this card's data to the passed card data
	data = cd
	#set the front and back texture
	frontTexture = cd.frontTexture
	backTexture = cd.backTexture
	#set the current texture to the back texture
	texture = backTexture


func flip():
	#check if this card is in a players hand
	if get_parent() is HandHandler:
		#since the parent has been verified to be a hand, put get_parent into a variable and cast it to HandHandler
		var hand = get_parent() as HandHandler
		#check if there are more than two flipped cards according to the parent, exit early if so
		if hand.cards_flipped > 1:
			return
		
		texture = frontTexture
		flipped = true
		#since we are now assuming this card is in the player's hand, increment the number of flipped cards in the hands
		hand.cards_flipped += 1

func hover():
	hovered = true
	if tween.is_running(): tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2,1.2), 0.2)

func unhover():
	hovered = false
	if tween.is_running(): tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 0.1)
