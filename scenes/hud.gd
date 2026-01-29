extends CanvasLayer


func update_suspicion(sus : int):
	get_tree().create_tween().tween_property($Control/MarginContainer/SuspicionMeter, "value", sus, 0.5)


func update_interaction(s : String, disable : bool = false):
	%InteractionLabel.text = "Tap E to talk to "+ s
	%InteractionLabel.visible = !disable
