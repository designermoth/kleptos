extends CharacterBody3D
class_name Player

signal EnteredInteraction
signal ExitedInteraction


const SPEED = 8.0

@export var current_mask : Character
var is_character_in_range = false
var character_interactable : Character

func _ready() -> void:
	EnteredInteraction.connect(_on_entered_interaction)
	ExitedInteraction.connect(_on_exited_interaction)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_character_in_range:
		Dialogic.VAR.relationship = (character_interactable.get(current_mask.name) as int) - 1
		Dialogic.VAR.has_location = character_interactable.has_location
		Dialogic.VAR.has_code = character_interactable.has_code
		Dialogic.start(character_interactable.name)


func change_character(c : Character):
	current_mask = c
	print(c.name)


#region Interaction

func _on_entered_interaction(c : Character):
	is_character_in_range = true
	character_interactable = c
	$HUD.update_interaction(c.name)


func _on_exited_interaction(c : Character):
	is_character_in_range = false
	character_interactable = null
	$HUD.update_interaction("",true)

#endregion
