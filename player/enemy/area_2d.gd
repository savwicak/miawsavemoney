extends Area2D

var captured := false

func catch_firefly():
	if captured:
		return

	captured = true
	queue_free()
