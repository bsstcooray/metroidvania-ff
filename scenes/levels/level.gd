extends Node2D

class_name Level

# Level controller - manages enemies, transitions, and level-specific logic

var player: Player
var enemies: Array[Enemy] = []

func _ready():
	player = $Player
	# Get all enemies from the Enemies node
	for enemy in $Enemies.get_children():
		if enemy is Enemy:
			enemies.append(enemy)
	
	print("Level loaded with ", enemies.size(), " enemies")

func _process(_delta):
	# Check win condition (all enemies defeated)
	if enemies.is_empty():
		print("All enemies defeated! Level complete!")

func add_enemy(enemy: Enemy):
	enemies.append(enemy)
	$Enemies.add_child(enemy)

func remove_enemy(enemy: Enemy):
	enemies.erase(enemy)
