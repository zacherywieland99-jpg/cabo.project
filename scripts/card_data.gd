extends Resource
class_name CardData

@export var displayName : String

@export var value = 0
@export var suit : SUITS

@export var frontTexture : Texture2D
@export var backTexture : Texture2D

enum SUITS  {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES
}


func activatePower():
	print(DeckHandler.dummyVar)
