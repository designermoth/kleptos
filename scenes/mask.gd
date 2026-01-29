extends Node3D


@export var character : Character
var mouse_inside = false

func _ready() -> void:
	await get_tree().create_timer(randf()).timeout
	$AnimationPlayer.play("idle")
