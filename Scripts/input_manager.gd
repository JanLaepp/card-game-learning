extends Node2D

signal left_mouse_button_clicked
signal left_mouse_button_released

var card_manager
var player_deck
# Called when the node enters the scene tree for the first time.
func _ready():
	card_manager = $"../CardManager"
	player_deck = $"../PlayerDeck"



func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			left_mouse_button_clicked.emit()
			raycast_at_cursor()
		else:
			left_mouse_button_released.emit()
			

func raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var results = space_state.intersect_point(parameters)
	if results.size() > 0:
		var results_collision_mask = results[0].collider.collision_mask
		if results_collision_mask == Globals.collision_mask_dict.get("card"):
			var card_found = get_card_with_highest_z_index(results)
			if card_found:
				card_manager.start_drag(card_found)
		elif results_collision_mask == Globals.collision_mask_dict.get("deck"):
			player_deck.draw_card()

func get_card_with_highest_z_index(card_array):
	if card_array.size() == 0:
		return null
	else:
		var highest_z_card = card_array[0].collider.get_parent()
		var highest_z_index = highest_z_card.z_index
		for card in card_array:
			var card_z_index = card.collider.get_parent().z_index
			if card_z_index > highest_z_index:
				highest_z_card = card.collider.get_parent()
				highest_z_index = card_z_index
		return highest_z_card
