extends Node3D


@export var character : Character
var mouse_inside = false

func _ready() -> void:
	await get_tree().create_timer(randf()).timeout
	$AnimationPlayer.play("idle")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse_inside:
		owner.owner.change_character(character)


func _process(delta: float) -> void:
	if mouse_inside:
		print(character.name)

func _on_area_3d_mouse_entered() -> void:
	mouse_inside = true


func _on_area_3d_mouse_exited() -> void:
	mouse_inside = false
