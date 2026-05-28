extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
