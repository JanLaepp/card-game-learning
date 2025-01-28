extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = Globals.z_index_dict.get("card_slot")
	scale = Vector2(Globals.scale_dict.get("card_slot"),Globals.scale_dict.get("card_slot"))
