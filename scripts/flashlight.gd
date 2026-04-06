extends SpotLight3D
@export var max_battery := 100.0
var battery := max_battery
@onready var flashlight = $Head/flashlight

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight") and $"../../ProgressBar".value > 0:
		$".".light_energy = 16
	else:
			$".".light_energy = 0
			
func _physics_process(_delta: float) -> void:
	if light_energy == 16:
		battery -= 1
		battery= clamp(battery, 0, max_battery)
		$ProgressBar.value = battery
		
	

func add_battery(amount):
	battery = clamp(battery + amount, 0, max_battery)
	$ProgressBar. value = battery
