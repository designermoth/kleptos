extends CharacterBody3D
class_name Player

signal EnteredInteraction
signal ExitedInteraction


const SPEED = 8.0
const RAY_LENGTH = 1000

@export var current_mask : Character
var is_character_in_range = false
var character_interactable : Character
var suspicion_level = 0
@export var max_suspicion = 100

var mask_held : Character

func _ready() -> void:
	EnteredInteraction.connect(_on_entered_interaction)
	ExitedInteraction.connect(_on_exited_interaction)


func _physics_process(delta: float) -> void:
	raycast_mask()
	add_movement(delta)


func raycast_mask():
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = false
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	if result.size() > 0 && $Pivot.visible && result.collider.owner.visible:
		mask_held = result.collider.owner.character
	else:
		mask_held = null

func add_movement(delta):
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
	if event.is_action_pressed("mask"):
		$Pivot.visible = true
	if event.is_action_released("mask"):
		$Pivot.visible = false
	if event is InputEventMouseButton && not mask_held == null:
		current_mask = mask_held

func add_mask(c : Character):
	for m in $Pivot.get_children():
		if m.character == c:
			m.visible = true


func add_suspicion(sus : int):
	suspicion_level += sus
	$HUD.update_suspicion(suspicion_level)
	if suspicion_level >= max_suspicion:
		print("SUS ENDING")


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
