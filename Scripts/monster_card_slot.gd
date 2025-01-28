extends Node2D

var card_in_slot = false
var card_slot_type = "Monster"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.set_collision_mask_value(Globals.collision_mask_dict.get("card_slot"), true)
	$Area2D.collision_layer = Globals.collision_layer_dict.get("card_slot")
	z_index = Globals.z_index_dict.get("card_slot")
	scale = Vector2(Globals.scale_dict.get("card_slot"),Globals.scale_dict.get("card_slot"))
