extends Node

class_name StateMachine

# State machine - manages player states and transitions

var current_state: PlayerState
var player: Player
var states: Dictionary = {}

func _ready():
	pass

func init(player_ref: Player):
	player = player_ref
	
	# Register all states
	for state in get_children():
		if state is PlayerState:
			states[state.name] = state
			state.state_machine = self
			state.player = player
	
	# Start with Idle state
	change_state("IdleState")

func change_state(state_name: String):
	if current_state:
		current_state.on_exit()
	
	current_state = states.get(state_name)
	if current_state:
		current_state.on_enter()

func process_input(input_vector: Vector2):
	if current_state:
		current_state.handle_input(input_vector)

func process_physics(delta: float):
	if current_state:
		current_state.update(delta)
