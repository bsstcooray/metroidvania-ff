extends PlayerState

var has_jumped: bool = false
var jump_count: int = 0
var max_jumps: int = 1

func on_enter():
	has_jumped = true
	jump_count = 1
	# Check if double jump is unlocked
	max_jumps = 2 if player.can_double_jump else 1
	player.velocity.y = player.JUMP_FORCE

func handle_input(input_vector: Vector2):
	# Second jump (double jump)
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps and player.can_double_jump:
		jump_count += 1
		player.velocity.y = player.JUMP_FORCE
		return
	
	# Attack input
	if Input.is_action_just_pressed("attack"):
		change_state("AttackState")
		return

func update(delta: float):
	# Horizontal movement
	var input_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = input_x * player.SPEED
	
	# Fall when reaching peak
	if player.velocity.y > 0:
		change_state("FallState")
		return
	
	# Landing
	if player.is_on_floor():
		if input_x != 0:
			change_state("RunState")
		else:
			change_state("IdleState")
