@tool
extends EditorScript

const IMAGE_DIR := {
	"Clubs": "res://cards/Clubs",
	"Diamonds": "res://cards/Diamonds",
	"Hearts": "res://cards/Hearts",
	"Spades": "res://cards/Spades",
}
const OUTPUT_DIR := "res://cards/card_data"
const BACK_IMAGE := "res://Red-Cover.png"
const RANKS := ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]


func _run() -> void:
	var back: Texture2D = load(BACK_IMAGE) if ResourceLoader.exists(BACK_IMAGE) else null
	if back == null:
		push_warning("no back texture at " + BACK_IMAGE)
	DirAccess.make_dir_recursive_absolute(OUTPUT_DIR)

	var made := 0
	for suit in IMAGE_DIR:
		for rank_index in RANKS.size():
			var rank: String = RANKS[rank_index]
			var image := "%s/%s-%s.png" % [IMAGE_DIR[suit], rank, suit]
			if not ResourceLoader.exists(image):
				push_error("missing image: " + image)
				continue

			var card := CardData.new()
			card.displayName = "%s of %s" % [rank, suit]
			card.value = rank_index + 1
			card.suit = CardData.SUITS[suit.to_upper()]
			card.frontTexture = load(image)
			card.backTexture = back

			var out := "%s/%s_%s.tres" % [OUTPUT_DIR, suit, rank]
			var err := ResourceSaver.save(card, out)
			if err != OK:
				push_error("save failed (%d): %s" % [err, out])
				continue
			made += 1

	EditorInterface.get_resource_filesystem().scan()
	print("created %d card resources" % made)
