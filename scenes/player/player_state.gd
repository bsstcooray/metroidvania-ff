extends Node

class_name PlayerState

# Base class for all player states

var state_machine: StateMachine
var player: Player

func on_enter():
	pass

func on_exit():
	pass

func handle_input(input_vector: Vector2):
	pass

func update(delta: float):
	pass

func change_state(state_name: String):
	state_machine.change_state(state_name)
