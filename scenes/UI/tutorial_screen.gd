extends CanvasLayer
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E:
			#start 
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			pass
			
