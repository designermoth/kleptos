extends Node3D


func _on_interaction_area_3d_body_entered(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("EnteredInteraction", name)


func _on_interaction_area_3d_body_exited(player: Player) -> void:
	if player == null:
		return
	player.emit_signal("ExitedInteraction", name)
