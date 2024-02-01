extends MarginContainer


#region vars
@onready var bg = $BG
@onready var icon = $HBox/Icon

var dice = null
var type = null
var subtype = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	dice = input_.dice
	type = input_.type
	subtype = input_.subtype
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.type = type
	input.subtype = subtype
	icon.set_attributes(input)
	custom_minimum_size = Vector2(Global.vec.size.facet)
	icon.custom_minimum_size = Vector2(Global.vec.size.facet *0.75)
	
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.quality[subtype]
#endregion
