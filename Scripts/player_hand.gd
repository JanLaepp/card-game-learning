extends Node2D

var player_deck
var hand_y_pos

var player_hand = []
var center_screen_x
var card_width
func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2
	player_deck = $"../PlayerDeck"
	hand_y_pos = player_deck.position.y

func add_card_to_hand(new_card) -> void:
	player_hand.insert(0,new_card)
	set_card_width()
	update_hand_positions()

func snap_card_back_to_hand(card):
	animate_card_to_position(card, card.position_in_hand)
	
func update_hand_positions() -> void:
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i), hand_y_pos)
		var card = player_hand[i]
		card.position_in_hand = new_position
		animate_card_to_position(card, new_position)
		
func calculate_card_position(index):
	var x_offset = (player_hand.size() -1) * card_width
	var x_position = center_screen_x + index * card_width - x_offset / 2
	return x_position

func animate_card_to_position(card, new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, 0.1)

func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		set_card_width()
		update_hand_positions()
		
func set_card_width():
	card_width = max(200 - (player_hand.size() * 8),80)
