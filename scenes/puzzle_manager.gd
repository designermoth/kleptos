extends Node3D

enum LOCATIONS {Left, Middle, Right}

var code = "123"
var location : LOCATIONS

var character_array : Array[Character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_characters()
	setup()
	Dialogic.signal_event.connect(_on_get_information)


func load_characters():
	var path = ResourceLoader.list_directory("res://resources")
	for p in path:
		character_array.append(ResourceLoader.load("res://resources/" + p) as Character)

func setup():
	code = str(randi_range(0,999))
	location = randi_range(0,2) as LOCATIONS
	character_array.pick_random().has_location = true
	var poss = character_array.duplicate()
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 1
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 2
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 3
	


func _on_get_information(argument : String):
	if argument == "get_location":
		Dialogic.VAR.answer = str(LOCATIONS.find_key(location))
	else: 
		var c = character_array[character_array.find_custom(func (x) : return x.name == argument)]
		Dialogic.VAR.answer = code[c.has_code - 1] if c.has_code else ""
		Dialogic.VAR.position = "First" if c.has_code == 1 else "Second" if c.has_code == 2 else "Third"
