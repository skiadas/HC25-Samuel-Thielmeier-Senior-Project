# Enemy script -> reusable script for the enemy AI behaviors including movement, attack, and updating animation
# To import to new enemy, right click on new_enemy in their scene, click attatch script, and type in enemy.gd

extends CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D
var speed = 50
var last_direction = Vector2.ZERO
@onready var animation_tree : AnimationTree = $AnimationTree
var direction_change_timer = 0
var direction_change_interval = 3
var run_speed = 75
var run = false
var player = null
var player_in_range = false
var is_attacking


func _ready():
	animation_tree.active = true
	# fixes error where enemy gets stuck on top of player head
	platform_floor_layers = false
	# Picks a random direction for the sprite to start in
	pick_random_direction()
	add_to_group("Enemy")
	
func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	if run:
		var direction_to_player = (target_to_chase.global_position - global_position).normalized()
		navigation_agent.target_position = target_to_chase.global_position
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * run_speed
		last_direction = direction_to_player # Update the last direction to face the player

	elif player_in_range:
		# Attack the player, set direction to face the player
		var direction_to_player = (target_to_chase.global_position - global_position).normalized()
		last_direction = direction_to_player # Ensure the attack faces the player
	
	else:
		# Random walking direction logic
		direction_change_timer += delta
		if direction_change_timer >= direction_change_interval:
			pick_random_direction()
			direction_change_timer = 0

		velocity = last_direction * speed

	move_and_slide()


# Picks a random direction for enemy
func pick_random_direction():
	var new_direction = Vector2.ZERO
	#Ensure that the direction is never a zero vector
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction # Update last direction variable
	
func update_animation_parameters():
	
	# Updates the conditions in the AnimationTree -> Parameters -> Conditions
	if(not velocity == Vector2.ZERO and not is_attacking):
		animation_tree["parameters/conditions/is_moving"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = false
	if(is_attacking == true):
		animation_tree["parameters/conditions/attack"] = true
	else:
		animation_tree["parameters/conditions/attack"] = false
	
	if last_direction != Vector2.ZERO:
		animation_tree["parameters/move/blend_position"] = last_direction
		animation_tree["parameters/attack/blend_position"] = last_direction

func _on_territory_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		run = true


func _on_territory_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		run = false
		pick_random_direction()
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		is_attacking = true
		animation_tree["parameters/conditions/attack"] = true
		print("Attacking")

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		is_attacking = false
		animation_tree["parameters/conditions/attack"] = false
		print("Player exited hitbox")
