extends Node3D


@export var max_battery := 100.0
@export var battery_drain_rate := 2.0
var battery := max_battery
var flashlight_on := false

func _ready():
	battery_bar.max_value = max_battery
	battery_bar.value = battery


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight") and $"../ProgressBar".value > 0:
		$flashlight.light_energy = 1
	else:
			$flashlight.light_energy = 0
			


@onready var flashlight = $flashlight
@onready var battery_bar = $"../ProgressBar"

func _process(delta:float) -> void:
	handle_toggle()
	handle_battery(delta)
	update_flashlight()
	update_ui()


# Toggle 
func handle_toggle():
	if Input.is_action_just_pressed("flashlight"):
		if battery > 0:
			flashlight_on = !flashlight_on



# Battery drain
func handle_battery (delta):
	if flashlight_on:
		battery -= battery_drain_rate * delta
	if battery <= 0:
		battery = 0
		flashlight_on = false 


#  Apply flashlight state
func update_flashlight():
	flashlight.visible = flashlight_on
	flashlight.light_energy = 1 if flashlight_on else 0


# UI update
func update_ui ():
	battery_bar.value = battery
