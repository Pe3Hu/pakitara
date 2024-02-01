extends MarginContainer


#region vars
@onready var churches = $Churches

var sketch = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_churchs()


func init_churchs() -> void:
	for _i in 1:
		var input = {}
		input.cradle = self
	
		var church = Global.scene.church.instantiate()
		churches.add_child(church)
		church.set_attributes(input)
#endregion
