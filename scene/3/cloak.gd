extends MarginContainer


#region vars
@onready var amulets = $Amulets

var proprietor = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_amulets()


func init_amulets() -> void:
	var limits = {}
	limits["bronze"] = 99
	
	for quality in Global.arr.quality:#limits:
		var input = {}
		input.cloack = self
		input.quality = quality
		input.limit = limits["bronze"]#limits[quality]
		
		var amulet = Global.scene.amulet.instantiate()
		amulets.add_child(amulet)
		amulet.set_attributes(input)


func roll_amulets_thickness() -> void:
	var limit = 10
	var options = {}
	
	for amulet in amulets.get_children():
		options[amulet] = Global.num.thickness.max - amulet.thickness
	
	while limit > 0:
		var amulet = Global.get_random_key(options)
		Global.rng.randomize()
		var maximum = min(limit, Global.num.thickness.max - amulet.thickness)
		var value = Global.rng.randi_range(1, maximum)
		amulet.change_thickness(value)
		limit -= value
		options[amulet] -= value
		
		if options[amulet] == 0:
			options.erase(amulet)


func sort_amulets_thickness() -> void:
	var array = []
	
	while amulets.get_child_count() > 0:
		var amulet = amulets.get_child(0)
		amulets.remove_child(amulet)
		array.append(amulet)
	
	array.sort_custom(func(a, b): return a.thickness < b.thickness)
	
	for amulet in array:
		amulets.add_child(amulet)
#endregion
	
