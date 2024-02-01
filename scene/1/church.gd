extends MarginContainer


#region vars
@onready var priests = $HBox/Priests

var cradle = null
var battleground = null
var sequences = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	cradle = input_.cradle
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_priests()
	


func init_priests() -> void:
	for _i in 1:
		var input = {}
		input.church = self
	
		var priest = Global.scene.priest.instantiate()
		priests.add_child(priest)
		priest.set_attributes(input)
#endregion
