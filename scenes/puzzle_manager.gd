extends Node3D

enum LOCATIONS {Left, Middle, Right}

var code = "123"
var location : LOCATIONS

var character_array : Array[Character]


@export_category("Sounds")
@export var sound_negative : AudioStream
@export var sound_neutral : AudioStream
@export var sound_positive : AudioStream
@export var sound_sus_time : AudioStream
@export var sound_win : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_characters()
	setup()
	Dialogic.signal_event.connect(_on_get_information)


func play_sound(a : AudioStream):
	$AudioStreamPlayer3D.stream = a
	$AudioStreamPlayer3D.play()


func load_characters():
	var path = ResourceLoader.list_directory("res://resources")
	for p in path:
		character_array.append(ResourceLoader.load("res://resources/" + p) as Character)

func setup():
	code = str(randi_range(100,999))
	location = randi_range(0,2) as LOCATIONS
	character_array.pick_random().has_location = true
	var poss = character_array.duplicate()
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 1
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 2
	poss.pop_at(randi_range(0,poss.size() - 1)).has_code = 3
	


func _on_get_information(argument : String):
	if argument == "get_location":
		Dialogic.VAR.answer = str(LOCATIONS.find_key(location))
		play_sound(sound_positive)
	elif argument == "get_not_location":
		play_sound(sound_neutral)
		var loc = location + 1 if location <= 1 else location - 1
		Dialogic.VAR.answer = str(LOCATIONS.find_key(loc))
	elif argument.begins_with("new_mask"):
		play_sound(sound_positive)
		var c = character_array[character_array.find_custom(func (x) : return x.name == argument.right(argument.length() - 8))]
		owner.get_node("Player").add_mask(c)
	elif argument.begins_with("add_suspicion"):
		play_sound(sound_negative)
		owner.get_node("Player").add_suspicion(argument.right(2).to_int())
	elif argument == "check_code":
		if str(Dialogic.VAR.input) == code:
			print(str(Dialogic.VAR.coffer) + "|" + str(LOCATIONS.find_key(location)))
			if str(Dialogic.VAR.coffer) == str(LOCATIONS.find_key(location)):
				win()
			else:
				play_sound(sound_negative)
				owner.get_node("Player").add_suspicion(50)
		else:
			owner.get_node("Player").add_suspicion(100)
	else: 
		play_sound(sound_positive)
		var c = character_array[character_array.find_custom(func (x) : return x.name == argument)]
		Dialogic.VAR.answer = code[c.has_code - 1] if c.has_code else ""
		Dialogic.VAR.position = "First" if c.has_code == 1 else "Second" if c.has_code == 2 else "Third"


func win():
	play_sound(sound_positive)
	get_tree().change_scene_to_file("res://scenes/UI/victory_screen.tscn")

func _on_suspicion_timer_timeout() -> void:
	play_sound(sound_sus_time)
	owner.get_node("Player").add_suspicion(10)
