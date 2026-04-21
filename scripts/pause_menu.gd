extends Control

var mouse_captured = false

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true


func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and !get_tree().paused:
			capture_mouse()
			
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			release_mouse()
	
func _ready() -> void:
	$pause.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		$pause.visible = !$pause.visible
		get_tree().paused = $pause.visible
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
