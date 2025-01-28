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
	scale = Vector2(Globals.scale_dict.get("card_in_hand"),Globals.scale_dict.get("card_in_hand"))
	get_parent().connect_card_signal(self)

func _on_area_2d_mouse_entered():
	hovered.emit(self)

func _on_area_2d_mouse_exited():
	hovered_off.emit(self)

func drop_in_slot(card_slot):
	position = card_slot.position
	$Area2D/CollisionShape2D.disabled = true
	scale = Vector2(Globals.scale_dict.get("card_in_slot"),Globals.scale_dict.get("card_in_slot"))
	z_index = Globals.z_index_dict.get("card_in_slot")
	in_slot = true
	
