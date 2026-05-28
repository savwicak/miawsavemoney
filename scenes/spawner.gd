extends Node2D

@export var object_scene: PackedScene
@export var spawn_interval: float = 1.0
@export var max_objects: int = 20

# Area spawn random
@export var min_position: Vector2 = Vector2(-800, -400)
@export var max_position: Vector2 = Vector2(800, 400)

func _ready():
	randomize()
	start_spawning()

func start_spawning() -> void:
	while true:
		if get_child_count() < max_objects:
			spawn_object()

		await get_tree().create_timer(spawn_interval).timeout

func spawn_object() -> void:
	if object_scene == null:
		return

	var obj = object_scene.instantiate()

	obj.position = Vector2(
		randf_range(min_position.x, max_position.x),
		randf_range(min_position.y, max_position.y)
	)

	add_child(obj)
