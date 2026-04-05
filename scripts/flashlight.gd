extends SpotLight3D



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight") and $"../../ProgressBar".value > 0:
		$".".light_energy = 16
	else:
			$".".light_energy = 0
			
func _physics_process(_delta: float) -> void:
	if $".".light_energy == 16:
		$"../../ProgressBar".value -= 1
