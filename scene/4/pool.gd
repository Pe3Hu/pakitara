extends MarginContainer


#region vars
@onready var dices = $Dices

var proprietor = null
var result = null
var rolls = []
var fixed = false
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor  = input_.proprietor


func add_dice(role_: String, facets_: int) -> void:
	var input = {}
	input.pool = self
	input.role = role_
	input.facets = facets_
	
	var dice = Global.scene.dice.instantiate()
	dices.add_child(dice)
	dice.set_attributes(input)
#endregion


#region roll
func roll_dices() -> void:
	rolls = []
	result = null
	
	for dice in dices.get_children():
		rolls.append(dice)
	
	for dice in dices.get_children():
		dice.roll()


func dice_stopped(dice_: MarginContainer) -> void:
	rolls.erase(dice_)
	
	if rolls.is_empty():
		update_result()


func update_result() -> void:
	result = 0
	var data = {}
	data.subtypes = []
	
	for dice in dices.get_children():
		data.subtypes.append(dice.get_current_facet_subtype())
	
	data.value = result
	#print(data)
	#proprietor.results.append(data)
	#proprietor.check_results()


func reset() -> void:
	fixed = false
	result = 0
	rolls = []
	
	while dices.get_child_count() > 0:
		var dice = dices.get_child(0)
		dices.remove_child(dice)
		dice.queue_free()


func set_fixed_value(value_: int) -> void:
	var dice = dices.get_child(0)
	dice.flip_to_value(value_)
#endregion
