extends PlayerState

var attack_timer: float = 0.0
var attack_duration: float = 0.5

func on_enter():
	attack_timer = 0.0
	# Create attack hitbox or play animation
	print("Attack!")

func update(delta: float):
	attack_timer += delta
	
	# Maintain horizontal velocity during attack
	var input_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = input_x * player.SPEED * 0.5  # Reduced speed during attack
	
	# End attack
	if attack_timer >= attack_duration:
		if not player.is_on_floor():
			change_state("FallState")
		elif input_x != 0:
			change_state("RunState")
		else:
			change_state("IdleState")
