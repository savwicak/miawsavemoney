extends CharacterBody2D

const MOVE_SPEED = 200.0
var current_look_dir = "right"

var can_slash: bool = true

@export var slash_time: float = 0.2
@export var sword_return_time: float = 0.5
@export var weapon_damage: float = 1.0

func _physics_process(delta: float) -> void:
	# =========================
	# MOVEMENT
	# =========================
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	# CharacterBody2D sudah memakai pixel/second,
	# jadi TIDAK perlu dikali delta.
	velocity = input * MOVE_SPEED
	move_and_slide()

	# =========================
	# FLIP CHARACTER BERDASARKAN POSISI MOUSE
	# =========================
	if current_look_dir == "right" and get_global_mouse_position().x < global_position.x:
		$icon/flip_anim.play("look_left")
		current_look_dir = "left"

	elif current_look_dir == "left" and get_global_mouse_position().x > global_position.x:
		$icon/flip_anim.play("look_right")
		current_look_dir = "right"

	# =========================
	# NET DI DEPAN / BELAKANG PLAYER
	# =========================
	if get_global_mouse_position().y > global_position.y:
		$icon/net.show_behind_parent = false
	else:
		$icon/net.show_behind_parent = true


	# =========================
	# ATTACK
	# =========================
	if Input.is_action_just_pressed("attack") and can_slash:
		can_slash = false

		# Atur kecepatan animasi agar durasinya = slash_time
		var anim_player = $icon/net/AnimationPlayer
		var anim = anim_player.get_animation("slash")

		if anim != null:
			anim_player.speed_scale = anim.length / slash_time

		anim_player.play("slash")


# Dipanggil di akhir animasi slash melalui Call Method Track
func end_slash() -> void:
	await get_tree().create_timer(sword_return_time).timeout
	can_slash = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		$icon/net/AnimationPlayer.speed_scale = $icon/net/AnimationPlayer.get_animation("net_return").length / sword_return_time
		$icon/net/AnimationPlayer.play("net_return")
	else:
		can_slash = true
