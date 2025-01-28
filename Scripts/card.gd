extends Node2D

signal hovered
signal hovered_off

var position_in_hand
var in_slot = false
var card_type
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.collision_mask = Globals.collision_mask_dict.get("card")
	$Area2D.collision_layer = Globals.collision_layer_dict.get("card")
	get_parent().connect_card_signal(self)

func _on_area_2d_mouse_entered():
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited():
	emit_signal("hovered_off", self)
