extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.direction = ["up", "right", "down", "left"]
	arr.quality = ["bronze", "silver", "gold", "platinum"]


func init_num() -> void:
	num.index = {}
	
	num.thickness = {}
	num.thickness.min = 1
	num.thickness.max = 6


func init_dict() -> void:
	init_neighbor()
	init_chain()
	init_dice()
	


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_chain() -> void:
	dict.chain = {}
	dict.chain.stage = {}
	dict.chain.stage[null] = "starter"
	dict.chain.stage["starter"] = "finisher"
	dict.chain.stage["finisher"] = "starter"
	
	dict.type = {}
	dict.type.facet = {}
	dict.type.facet["fight"] = "quality"
	dict.type.facet["craft"] = "outcome"


func init_dice() -> void:
	dict.dice = {}
	dict.dice.role = {}
	dict.dice.facets = {}
	
	var path = "res://asset/json/pakitara_dice.json"
	var array = load_data(path)
	var exceptions = ["role", "facets"]
	
	for dice in array:
		dice.facets = int(dice.facets)
		dice.count = int(dice.count)
		
		if !dict.dice.role.has(dice.role):
			dict.dice.role[dice.role] = {}
		
		if !dict.dice.role[dice.role].has(dice.facets):
			dict.dice.role[dice.role][dice.facets] = {}
		
		if !dict.dice.facets.has(dice.facets):
			dict.dice.facets[dice.facets] = {}
		
		if !dict.dice.facets[dice.facets].has(dice.role):
			dict.dice.facets[dice.facets][dice.role] = {}
		
		dict.dice.role[dice.role][dice.facets][dice.subtype] = dice.count
		dict.dice.facets[dice.facets][dice.role][dice.subtype] = dice.count


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.church = load("res://scene/1/church.tscn")
	scene.priest = load("res://scene/1/priest.tscn")
	
	scene.amulet = load("res://scene/3/amulet.tscn")
	
	scene.dice = load("res://scene/4/dice.tscn")
	scene.facet = load("res://scene/4/facet.tscn")


func init_vec():
	vec.size = {}
	vec.size.number = Vector2(32, 32)
	vec.size.sixteen = Vector2(16, 16)
	
	vec.size.facet = Vector2(vec.size.sixteen * 2)
	vec.size.amulet = Vector2(vec.size.sixteen * 4.5)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.quality = {}
	color.quality.miss = Color.from_hsv(0 / h, 0.0, 0.1)
	color.quality.bronze = Color.from_hsv(23 / h, 0.6, 0.6)
	color.quality.silver = Color.from_hsv(0 / h, 0.0, 0.6)
	color.quality.gold = Color.from_hsv(55 / h, 0.9, 0.9)
	color.quality.platinum = Color.from_hsv(160 / h, 0.9, 0.9)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
