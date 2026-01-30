extends CanvasLayer
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E:
			#start 
			get_tree().change_scene_to_file("res://scenes/UI/tutorial_screen.tscn")
			pass
		if event.pressed and event.keycode == KEY_Q:
			get_tree().quit()
			pass
		if event.pressed and event.keycode == KEY_F:
			get_tree().change_scene_to_file("res://scenes/UI/credits.tscn")
			pass
