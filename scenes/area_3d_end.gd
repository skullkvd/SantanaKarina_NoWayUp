extends Area3D




func _on_body_entered(body):
	print("entered:", body.name)
	
	if body is CharacterBody3D:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/ending.tscn")
