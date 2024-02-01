extends MarginContainer


#region vars
@onready var quality = $Quality
@onready var current = $HBox/Current
@onready var limit = $HBox/Limit
@onready var slash = $HBox/Slash

var cloack = null
var plate = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	cloack = input_.cloack
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_icons(input_)
	reset()


func init_icons(input_: Dictionary) -> void:
	var input = {}
	input.type = "quality"
	input.subtype = input_.quality
	quality.set_attributes(input)
	quality.custom_minimum_size = Global.vec.size.amulet
	
	input.type = "number"
	input.subtype = 0
	var keys = ["current", "limit"]
	
	for key in keys:
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Vector2()
	
	limit.set_number(input_.limit)
	
	input.type = "string"
	input.subtype = "/"
	slash.set_attributes(input)
	slash.custom_minimum_size = Vector2()


func reset() -> void:
	current.set_number(limit.get_number())
#endregion
