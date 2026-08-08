extends Node

var dummyVar = "yeah"

var drawPile : Array[CardData]
var discardPile : Array[CardData]

func _ready():
	shuffle()
# Called when the node enters the scene tree for the first time.
func draw() -> CardData:
	return preload("res://cards/card_data/1OFHEARTS.tres")


func discard(card : CardData):
	return

func shuffle():
	for file in DirAccess.open("res://cards/card_data").get_files():
		#collects all card images
		drawPile.append(load("res://cards/card_data/" + file))
		print(drawPile)
		
