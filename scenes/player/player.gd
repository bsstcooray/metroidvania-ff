extends CharacterBody2D

class_name Player

# Player class - handles movement, abilities, health, and state management

const SPEED = 150.0
const JUMP_FORCE = -400.0
const GRAVITY = 800.0

# Abilities
var can_double_jump: bool = false
var can_dash: bool = false
var can_wall_stick: bool = false
var can_ground_slam: bool = false
var can_morph_roll: bool = false

var is_alive: bool = true
var max_health: int = 10
var current_health: int = 10

var state_machine: StateMachine
var velocity_override: Vector2 = Vector2.ZERO
var use_velocity_override: bool = false

func _ready():
	# Setup collision shape
	var collision_shape = $CollisionShape2D
	var capsule = CapsuleShape2D.new()
	capsule.radius = 8
	capsule.height = 16
	collision_shape.shape = capsule
	
	# Get state machine
	state_machine = $StateMachine
	state_machine.init(self)
	
	# Initialize ability manager
	$AbilityManager.init(self)
	
	print("Player initialized with ", current_health, " health")

func _physics_process(delta):
	if not is_alive:
		return
	
	# Get input
	var input_vector = Input.get_vector("move_left", "move_right", "move_left", "move_right")
	
	# Apply gravity
	if not is_on_floor() and not use_velocity_override:
		velocity.y += GRAVITY * delta
	
	# Handle velocity override (for knockback, dash, etc.)
	if use_velocity_override:
		velocity = velocity_override
		use_velocity_override = false
	
	# Update state machine
	state_machine.process_input(input_vector)
	state_machine.process_physics(delta)
	
	# Move the character
	velocity = move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount
	print("Player took ", amount, " damage. Health: ", current_health)
	
	if current_health <= 0:
		die()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	print("Player healed for ", amount, ". Health: ", current_health)

func die() -> void:
	is_alive = false
	print("Player died!")
	# Play death animation
	# Reload level or show game over screen
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity

func unlock_ability(ability_name: String) -> void:
	match ability_name:
		"double_jump":
			can_double_jump = true
			print("Unlocked: Double Jump")
		"dash":
			can_dash = true
			print("Unlocked: Dash")
		"wall_stick":
			can_wall_stick = true
			print("Unlocked: Wall Stick")
		"ground_slam":
			can_ground_slam = true
			print("Unlocked: Ground Slam")
		"morph_roll":
			can_morph_roll = true
			print("Unlocked: Morph Roll")
