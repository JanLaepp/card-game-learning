extends Node2D

const card_highlight_scale = 1.05

var screen_size
var card_being_dragged
var highlighted_card
var player_hand

var played_monster_card_this_turn

# Called when the node enters the scene tree for the first time.
func _ready():
	played_monster_card_this_turn = false
	screen_size = get_viewport_rect().size
	player_hand = $"../PlayerHand"
	$"../InputManager".connect("left_mouse_button_released", on_left_mouse_button_released)


func on_left_mouse_button_released():
	if card_being_dragged:
		finish_drag()

func raycast_check_for_card():
	var card_array = raycast_check_for_objects("card")
	if card_array:
		return get_card_with_highest_z_index(card_array)
	else:
		return null

func raycast_check_for_card_slot():
	var card_slot_array = raycast_check_for_objects("card_slot")
	if card_slot_array:
		return card_slot_array[0].collider.get_parent()
	else:
		return null

func raycast_check_for_objects(object_type):
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = Globals.collision_mask_dict.get(object_type)
	var results = space_state.intersect_point(parameters)
	if results.size() > 0:
		return results
	else:
		return null

func get_card_with_highest_z_index(card_array):
	var highest_z_card = card_array[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	for card in card_array:
		var card_z_index = card.collider.get_parent().z_index
		if card_z_index > highest_z_index:
			highest_z_card = card.collider.get_parent()
			highest_z_index = card_z_index
	return highest_z_card

func start_drag(card):
	card_being_dragged = card
	card_being_dragged.scale /= card_highlight_scale

func try_drop_in_slot(card, card_slot):
	if played_monster_card_this_turn:
		return false
	if card_slot == null:
		return false
	if card_slot.card_in_slot:
		return false
	if card_slot.card_slot_type != card.card_type:
		return false
	return true

func finish_drag():
	if card_being_dragged:
		card_being_dragged.scale *= card_highlight_scale
		var card_slot = raycast_check_for_card_slot()
		if try_drop_in_slot(card_being_dragged,card_slot):
			played_monster_card_this_turn = true
			#finished dragging over an unoccupied card slot
			card_being_dragged.drop_in_slot(card_slot)
			card_slot.card_in_slot = true
			player_hand.remove_card_from_hand(card_being_dragged)
			on_hovered_off_card(card_being_dragged)
		else:
			player_hand.snap_card_back_to_hand(card_being_dragged)
		card_being_dragged = null

func connect_card_signal(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	if highlighted_card == null:
		highlight_card(card)

func on_hovered_off_card(card):
	if highlighted_card == card:
		dehighlight_card(card)
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered)

func highlight_card(card):
	highlighted_card = card
	if card_being_dragged == null:
		card.scale = card.scale * card_highlight_scale
		card.z_index = Globals.z_index_dict.get("card_highlighted")

func dehighlight_card(card):
	highlighted_card = null
	if card_being_dragged == null:
		card.scale = card.scale / card_highlight_scale
		card.z_index = Globals.z_index_dict.get("card_in_hand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x,0,screen_size.x),clamp(mouse_pos.y,0,screen_size.y))
