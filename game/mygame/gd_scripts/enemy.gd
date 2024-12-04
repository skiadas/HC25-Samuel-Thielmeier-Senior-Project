# Enemy script -> reusable script for the enemy AI behaviors including movement, attack, and updating animation

extends CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var hurtbox: Area2D = $hurtbox  # Ensure this references the hurtbox node
@export var target_to_chase: CharacterBody2D
var speed = 50
var last_direction = Vector2.ZERO
@onready var animation_tree: AnimationTree = $AnimationTree
# Variables to control pick_random_direction
var direction_change_timer = 0
var direction_change_interval = 3
var run_speed = 75 # To increase speed for when player is in range
var run = false
var player = null # Detecting player and if they are in range
var player_in_range = false
var is_attacking = false # Detects if the enemy is attacking
var health = 100
var is_dying = false # To insure the die() function only gets called once
var is_dead = false


func _ready():
	animation_tree.active = true
	platform_floor_layers = false  # fixes error where enemy gets stuck on top of player head
	pick_random_direction()  # Picks a random direction for the sprite to start in
	add_to_group("Enemy")

func _process(delta):
	update_animation_parameters()
	update_health()
	die()
	control_hurtbox()
	# Automatically set target_to_chase to a player in the "Player" group
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		target_to_chase = players[0]  # Assumes the first player in the group is the target

func _physics_process(delta):
	if is_attacking or is_dead:
		velocity = Vector2.ZERO
	elif run:
		chase_player()
	else:
		# Random walking direction logic
		change_direction(delta)
		velocity = last_direction * speed

	move_and_slide()
	
func control_hurtbox():
	# Moves the hurtbox to direction enemy is facing
	if hurtbox and last_direction != Vector2.ZERO:
		# Snap last_direction to the nearest cardinal direction
		if abs(last_direction.x) > abs(last_direction.y):
			last_direction = Vector2(1, 0) if last_direction.x > 0 else Vector2(-1, 0)  # Horizontal movement
		else:
			last_direction = Vector2(0, 1) if last_direction.y > 0 else Vector2(0, -1)  # Vertical movement
		hurtbox.facing_direction = last_direction
		hurtbox.update_position()

func chase_player():
	# Chases the player when enemy sees them, attack logic controlled by hurtbox node
	var direction_to_player = (target_to_chase.global_position - global_position).normalized()
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * run_speed
	last_direction = direction_to_player  # Update the last direction to face the player

func change_direction(delta):
	direction_change_timer += delta
	if direction_change_timer >= direction_change_interval:
		pick_random_direction()
		direction_change_timer = 0

func pick_random_direction():
	var new_direction = Vector2.ZERO
	# Ensure that the direction is never a zero vector
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction  # Update last direction variable
	
func update_animation_parameters():
	# Updates the conditions in the AnimationTree -> Parameters -> Conditions
	if is_dead:
		animation_tree["parameters/conditions/die"] = true
	else:
		animation_tree["parameters/conditions/die"] = false
	if not velocity == Vector2.ZERO and not is_attacking:
		animation_tree["parameters/conditions/is_moving"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = false
	if is_attacking:
		animation_tree["parameters/conditions/attack"] = is_attacking
	else:
		animation_tree["parameters/conditions/attack"] = is_attacking
	update_blend_positions()

func update_blend_positions():
	if last_direction != Vector2.ZERO:
		animation_tree["parameters/move/blend_position"] = last_direction
		animation_tree["parameters/attack/blend_position"] = last_direction

# To enable damage, called in the AnimationPlayer using the Call Method Track
func damage_player():
	if player_in_range and is_attacking:
		if player.has_method("take_damage"):
			player.take_damage()
			
func enemy_take_damage():
	if not is_dead:
		health -= 25

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func die():
	if health <= 0 and not is_dying:
		is_dying = true
		velocity = Vector2.ZERO
		is_dead = true
		if player and player.has_method("on_enemy_killed"):
			player.on_enemy_killed()
		await get_tree().create_timer(1.0).timeout
		queue_free()
	

func _on_territory_body_entered(body: Node2D) -> void:
	# Detects the player when player enters territory
	if body.is_in_group("Player"):
		player = body
		run = true

func _on_territory_body_exited(body: Node2D) -> void:
	# Loses track of player when player leaves territory
	if body.is_in_group("Player"):
		player = null
		run = false
		pick_random_direction()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	# Handles activating the attack parameters
	if body.is_in_group("Player"):
		player_in_range = true
		is_attacking = true
		animation_tree["parameters/conditions/attack"] = true
		print("Enemy Attacking")

func _on_hurtbox_body_exited(body: Node2D) -> void:
	# Turns off the attack parameters
	if body.is_in_group("Player"):
		player_in_range = false
		is_attacking = false
		animation_tree["parameters/conditions/attack"] = false
		print("Player exited enemy hurtbox")
