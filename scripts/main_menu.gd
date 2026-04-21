extends Control




func _on_start_pressed() -> void:
	print("Switching to:", "res://main.tscn")
	var err = get_tree().change_scene_to_file("res://main.tscn")
	print("Result:", err)



func _on_settings_pressed() -> void:
	print("settings")


func _on_quit_pressed() -> void:
	get_tree().quit()
