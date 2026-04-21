extends Area3D


@export var scene_name: String


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/" +scene_name + ".tscn")
		print("entered:", body.name)
