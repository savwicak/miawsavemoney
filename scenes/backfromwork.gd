extends Node2D

@export var required_fireflies := 20
@export var next_scene := "res://scenes/win_scene.tscn"

func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")

	if player != null:
		if player.fireflies_caught >= required_fireflies:
			visible = true
		else:
			visible = false	
