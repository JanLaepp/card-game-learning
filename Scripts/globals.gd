extends Node

var starting_hand_size = 5

var collision_mask_dict = {
	"card" = 1,
	"card_slot" = 2,
	"deck" = 4
}

var collision_layer_dict = {
	"card" = 1,
	"card_slot" = 2,
	"deck" = 4
}

var scale_dict = {
	"card_in_hand" = 4,
	"card_in_slot" = 3,
	"deck" = 0.68,
	"card_slot" = 0.6
}

var z_index_dict = {
	"card_in_hand" = 2,
	"card_highlighted" = 3,
	"card_in_slot" = 1,
	"card_slot" = 1,
	"deck" = -2
}
