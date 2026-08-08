extends Control
class_name HandHandler

var fan_angle = 45
var cards_flipped = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 4):
		add_card()
	


func add_card():
	var c = DeckHandler.draw()
	var newCard = Card.new()
	newCard.loadcard(c)
	add_child(newCard)
	orient_cards()

func orient_cards():
	print("starting")
	var cnum = get_children().size()
	for idx in range(0, cnum):
		var c = get_child(idx)
		#c.rotation_degrees = (fan_angle/cnum)*idx
		c.position.x = (size.x/cnum)*idx
