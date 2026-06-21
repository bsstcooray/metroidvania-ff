extends PlayerState

func handle_input(input_vector: Vector2):
	# Jump from air if double jump available
	if Input.is_action_just_pressed("jump") and player.can_double_jump:
		change_state("JumpState")
		return
	
	# Attack input
	if Input.is_action_just_pressed("attack"):
		change_state("AttackState")
		return

func update(delta: float):
	# Horizontal movement
	var input_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = input_x * player.SPEED
	
	# Landing
	if player.is_on_floor():
		if input_x != 0:
			change_state("RunState")
		else:
			change_state("IdleState")
