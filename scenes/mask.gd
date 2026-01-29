extends Node3D


@export var character : Character
@export var material : StandardMaterial3D
var mouse_inside = false

func _ready() -> void:
	$"Mascara Base/Mask".material_override = material
	$AnimationPlayer.play("idle")
