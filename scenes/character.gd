extends Node3D

@export var character_res : Character
@export var col_disabled = false

var speed = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree


func _ready() -> void:
	$StaticBody3D/CollisionShape3D.disabled = col_disabled
	$InteractionArea3D/CollisionShape3D.disabled = col_disabled
	

func _on_interaction_area_3d_body_entered(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("EnteredInteraction", character_res)


func _on_interaction_area_3d_body_exited(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("ExitedInteraction", character_res)


func _physics_process(delta: float) -> void:
	#print(speed.length())
	animation_tree.set("parameters/blend_position",speed.length() / 8.0)
