extends Node3D
var who_asked_simon_green = ["simon","ruben","andre"]
var suspicion_level = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_alreadyasked_check)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_alreadyasked_check (argument: String):
	if (who_asked_simon_green.find("andre")) == -1:
		who_asked_simon_green.append("andre")
		pass
	else:
		suspicion_level += 1
		pass
	pass
