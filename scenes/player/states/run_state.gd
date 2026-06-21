extends PlayerState

var current_input: Vector2 = Vector2.ZERO

func handle_input(input_vector: Vector2):
	current_input = input_vector
	
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
	
	# No input
	if input_vector.x == 0:
		change_state("IdleState")
		return

func update(delta: float):
	# Apply gravity
	if not player.is_on_floor():
		change_state("FallState")
		return
	
	# Move horizontally
	player.velocity.x = current_input.x * player.SPEED
