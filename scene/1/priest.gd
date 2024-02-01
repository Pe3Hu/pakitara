extends MarginContainer


#region vars
@onready var cloak = $HBox/VBox/Cloak
@onready var pool = $HBox/VBox/Pool

var church = null
var sequence = null
var index = null
var quadrant = null
var origin = null
var stage = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	church = input_.church
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.proprietor = self
	cloak.set_attributes(input)
	pool.set_attributes(input)
	
	for _i in 3:
		pool.add_dice("fight", 4)
	
	pool.roll_dices()
#endregion


