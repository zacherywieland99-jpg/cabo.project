extends Resource
class_name CardData

enum SUITS {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES,
}

@export var displayName: String
@export var value: int = 0
@export var suit: SUITS
@export var frontTexture: Texture2D
@export var backTexture: Texture2D


func activatePower() -> void:
	print(DeckHandler.dummyVar)
	pass
