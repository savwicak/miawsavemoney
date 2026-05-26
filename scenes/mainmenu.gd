extends Control

func _on_work_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/work.tscn")

func _on_bedroom_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/room.tscn")

func _on_docs_btn_pressed() -> void:
	pass # Replace with function body.
