extends PlayerState

func handle_input(input_vector: Vector2):
	# Stop crouching
	if not Input.is_action_pressed("crouch"):
		if input_vector.x != 0:
			change_state("RunState")
		else:
			change_state("IdleState")
		return

func update(delta: float):
	# Stop horizontal movement while crouching
	player.velocity.x = 0
	
	# Fall when not on ground
	if not player.is_on_floor():
		change_state("FallState")
