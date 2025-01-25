extends Node2D

const HAND_COUNT = 6
const CARD_SCENE_PATH = "res://Scenes/card.tscn"

const HAND_Y_POS = 890

var player_hand = []
var center_screen_x
var card_width
func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2
	
	var card_manager = $"../CardManager"
	var card_scene = preload(CARD_SCENE_PATH)
	for i in range(HAND_COUNT):
		var new_card = card_scene.instantiate()
		card_manager.add_child(new_card)
		new_card.name = "Card"
		add_card_to_hand(new_card)


func add_card_to_hand(new_card) -> void:
	print("adding card to hand")
	player_hand.insert(0,new_card)
	set_card_width()
	update_hand_positions()

func snap_card_back_to_hand(card):
	animate_card_to_position(card, card.position_in_hand)
	
func update_hand_positions() -> void:
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POS)
		var card = player_hand[i]
		card.position_in_hand = new_position
		animate_card_to_position(card, new_position)
		
func calculate_card_position(index):
	var x_offset = (player_hand.size() -1) * card_width
	var x_position = center_screen_x + index * card_width - x_offset / 2
	return x_position

func animate_card_to_position(card, new_position):
	var tween = get_tree().create_tween()
	print("moving card to new position")
	tween.tween_property(card, "position", new_position, 0.1)

func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		set_card_width()
		update_hand_positions()
		
func set_card_width():
	card_width = max(250 - (player_hand.size() * 10),100)
