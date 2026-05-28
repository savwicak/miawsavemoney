extends Node2D

@export var required_fireflies := 20
@export var next_scene := "res://scenes/mainmenu.tcsn"

func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")

	if player != null:
		if player.fireflies_caught >= required_fireflies:
			visible = true
		else:
			visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_scene)
