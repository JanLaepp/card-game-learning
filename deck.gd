extends Node2D

const CARD_SCENE_PATH = "res://Scenes/card.tscn"

var player_deck = ["Knight","Knight","Knight","Knight","Knight","Knight","Knight","Knight"]
var player_hand
var card_manager
var card_scene
func _ready():
	$Area2D.collision_mask = Globals.collision_mask_dict.get("deck")
	$Area2D.collision_layer = Globals.collision_layer_dict.get("deck")
	$Sprite2D.z_index = -2
	$DeckCardCount.z_index = -2

	player_hand = $"../PlayerHand"
	card_manager = $"../CardManager"
	card_scene = preload(CARD_SCENE_PATH)
	
	$DeckCardCount.text = str(player_deck.size())
	
func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$DeckCardCount.visible = false
	$DeckCardCount.text = str(player_deck.size())
	var new_card = card_scene.instantiate()
	new_card.global_position = self.global_position
	card_manager.add_child(new_card)
	new_card.name = "Card"
	player_hand.add_card_to_hand(new_card)
