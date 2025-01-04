extends Node2D

var card_in_slot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.collision_mask = Globals.collision_mask_dict.get("card_slot")
	$Area2D.collision_layer = Globals.collision_layer_dict.get("card_slot")
