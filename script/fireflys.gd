extends CharacterBody2D

@export var move_speed: float = 20.0
@export var change_direction_time: float = 1.5
@export var movement_range: float = 30.0

var health: float = 3.0	

var direction: Vector2 = Vector2.ZERO
var origin_position: Vector2

func _ready():
	randomize()
	origin_position = position
	choose_new_direction()
	start_direction_loop()

func _process(delta):
	position += direction * move_speed * delta

	# Supaya tidak terlalu jauh dari posisi awal
	if position.distance_to(origin_position) > movement_range:
		direction = (origin_position - position).normalized()

func start_direction_loop() -> void:
	while true:
		await get_tree().create_timer(change_direction_time).timeout
		choose_new_direction()

func choose_new_direction() -> void:
	direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

func take_damage(weapon_damage: float):
	health -= weapon_damage
	
	if health <= 0.0:
		queue_free()
