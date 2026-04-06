extends Area3D

@export var recharge_amount := 50.0


func _on_body_entered(body: Node3D) -> void:
	print("Touched:", body.name)

	if body is CharacterBody3D:  # ✅ ensures it's the player
		if body.has_method("add_battery"):
			body.add_battery(recharge_amount)
			queue_free()
