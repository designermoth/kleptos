extends Node3D

@export var character_res : Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_area_3d_body_entered(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("EnteredInteraction", character_res)


func _on_interaction_area_3d_body_exited(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("ExitedInteraction", character_res)
