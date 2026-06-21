extends PlayerState

func handle_input(input_vector: Vector2):
	# Jump input
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		change_state("JumpState")
		return
	
	# Attack input
	if Input.is_action_just_pressed("attack"):
		change_state("AttackState")
		return
	
	# Crouch input
	if Input.is_action_pressed("crouch"):
		change_state("CrouchState")
		return
	
	# Move input
	if input_vector.x != 0:
		change_state("RunState")
		return

func update(delta: float):
	# Apply gravity
	if not player.is_on_floor():
		change_state("FallState")
		return
	
	# Stop horizontal movement
	player.velocity.x = 0
