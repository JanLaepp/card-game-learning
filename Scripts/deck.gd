extends Node2D

const CARD_SCENE_PATH = "res://Scenes/card.tscn"

var player_deck = ["Demon","Archer","Archer","Archer","Knight","Knight","Knight","Knight"]
var player_hand
var card_manager
var card_scene
var card_db

var card_drawn_this_turn
func _ready():
	$Area2D.collision_mask = Globals.collision_mask_dict.get("deck")
	$Area2D.collision_layer = Globals.collision_layer_dict.get("deck")
	$Sprite2D.z_index = Globals.z_index_dict.get("deck")
	$DeckCardCount.z_index = Globals.z_index_dict.get("deck")
	scale = Vector2(Globals.scale_dict.get("deck"),Globals.scale_dict.get("deck")-0.04)
	player_hand = $"../PlayerHand"
	card_manager = $"../CardManager"
	card_scene = preload(CARD_SCENE_PATH)
	card_db = preload("res://Scripts/card_db.gd")
	$DeckCardCount.text = str(player_deck.size())
	player_deck.shuffle()
	for i in range(Globals.starting_hand_size):
		draw_card()
		card_drawn_this_turn = false
	card_drawn_this_turn = true
		
	
	
func draw_card():
	if card_drawn_this_turn:
		return
	else:
		card_drawn_this_turn = true
		var card_drawn_name = player_deck[0]
		player_deck.erase(card_drawn_name)
		if player_deck.size() == 0:
			$Area2D/CollisionShape2D.disabled = true
			$Sprite2D.visible = false
			$DeckCardCount.visible = false
		$DeckCardCount.text = str(player_deck.size())
		var new_card = card_scene.instantiate()
		var card_image_path = str("res://Assets/" + card_drawn_name + "Card.png")
		new_card.get_node("CardImage").texture = load(card_image_path)
		new_card.get_node("AttackText").text = str(card_db.CARDS[card_drawn_name][0])
		new_card.get_node("HealthText").text = str(card_db.CARDS[card_drawn_name][1])
		new_card.card_type = card_db.CARDS[card_drawn_name][2]
		new_card.global_position = self.global_position
		card_manager.add_child(new_card)
		new_card.name = "Card"
		player_hand.add_card_to_hand(new_card)
		new_card.get_node("AnimationPlayer").play("card_flip")
