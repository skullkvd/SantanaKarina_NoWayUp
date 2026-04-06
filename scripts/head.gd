extends Node3D

# --- CONFIG ---
@export var max_battery := 100.0
@export var battery_drain_rate := 2.0
var battery := max_battery 
var flashlight_on := false

# --- NODE REFERENCES ---
@onready var flashlight = $flashlight
@export var battery_bar: ProgressBar

# --- READY ---

func _ready() -> void:
	if battery_bar:
		battery_bar.max_value = max_battery
		battery_bar.value = battery
		
# --- INPUT ---
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight") and battery > 0:
		flashlight_on = not flashlight_on
		update_flashlight()

# --- PROCESS ---
func _process(delta:float) -> void:
	handle_battery(delta)
	update_ui()
	
# --- BATTERY DRAIN ---
func handle_battery(delta: float) -> void:
	if flashlight_on:
		battery -= battery_drain_rate * delta
		battery = clamp(battery, 0, max_battery)
		
		# Automatically turn off flashlight if battery is empty
	
		if battery <= 0:
			flashlight_on = false
			update_flashlight()
			
# --- APPLY FLASHLIGHT STATE ---
func update_flashlight() -> void:
	flashlight.visible = flashlight_on
	flashlight.light_energy = 1 if flashlight_on else 0
	
# --- UPDATE UI ---
func update_ui () -> void:
	if battery_bar:
		battery_bar.value = battery 
		
		
# --- BATTERY PICKUP ---
func add_battery(amount: float) -> void:
	battery = clamp(battery + amount, 0, max_battery)
	update_ui()
	
