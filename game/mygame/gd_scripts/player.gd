# Script for controlling player movement, attack, and updating animations.

extends CharacterBody2D

var speed = 100.0
var tackle_speed = 200.0  # Speed boost during tackle
var tackle_duration = 0.5  # Tackle duration in seconds
var last_direction = Vector2.ZERO
var enemy_in_range = false
var is_attacking = false
var is_tackling = false
var offset_distance = 15  # Hurtbox Distance from the player

var direction : Vector2 = Vector2.ZERO

# Imports the AnimationTree node as the variable animation_tree
@onready var animation_tree : AnimationTree = $AnimationTree
# Reference to the hurtbox node
@onready var hurtbox = $hurtbox

func _ready():
	animation_tree.active = true
	add_to_group("Player")

@warning_ignore("unused_parameter")
func _process(delta):
	update_animation_parameters()

@warning_ignore("unused_parameter")
# Controls player movement only
func _physics_process(delta):
	# Prevent movement if player is attacking or tackling
	if is_attacking or is_tackling:
		velocity = Vector2.ZERO
	else:
		# Get input direction and move the character if not attacking or tackling
		# Keys mapped in Project -> Project Settings -> Input Map
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * speed

	if direction != Vector2.ZERO and not (is_attacking or is_tackling):
		last_direction = direction

	if is_tackling:
		# Move in the last direction during tackle
		velocity = last_direction * tackle_speed
	
	move_and_slide()

func update_animation_parameters():
	# Handle idle/walking animations
	idle_or_moveing()
	# Handle the attack animation (swing)
	if Input.is_action_just_pressed("swing") and not is_attacking:
		swing_sword()
	# Handle the tackle animation
	if Input.is_action_just_pressed("tackle") and not is_tackling:
		tackle()
	# Gets acurate blend positions
	update_blend_positions()
	# Moves hurtbox to infront of enemy
	control_hurtbox()
	
	# Ensure tackle uses corrected direction (4 cardinal directions only)
	if is_tackling:
		animation_tree["parameters/tackle/blend_position"] = last_direction
		
		
func idle_or_moveing():
	if velocity == Vector2.ZERO and not is_attacking and not is_tackling:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true

func tackle():
	is_tackling = true
	if abs(last_direction.x) > abs(last_direction.y):
			# Move horizontally (left or right)
		last_direction = Vector2(last_direction.x, 0).normalized()
	else:
			# Move vertically (up or down)
		last_direction = Vector2(0, last_direction.y).normalized()
	
	animation_tree["parameters/conditions/tackle"] = true
	await get_tree().create_timer(tackle_duration).timeout  # Wait for tackle duration
	is_tackling = false
	animation_tree["parameters/conditions/tackle"] = false

func swing_sword():
	is_attacking = true
	animation_tree["parameters/conditions/swing"] = true
	#print("Swing started, is_attacking set to true")
	
	await get_tree().create_timer(0.5).timeout  # Wait for swing duration
	is_attacking = false
	#print("Swing ended, is_attacking set to false")
	animation_tree["parameters/conditions/swing"] = false

func damage_enemy():
	if enemy_in_range:
		print("Player Hit the Enemy!")

func update_blend_positions():
		# Update blend position (for direction in animations)
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/swing/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction

func control_hurtbox():
	if direction != Vector2.ZERO and not (is_attacking or is_tackling):
		last_direction = direction
		hurtbox.facing_direction = last_direction  # Update hurtbox facing direction
		hurtbox.update_position(offset_distance)  # Reposition hurtbox based on direction (update_position() located in hurtbox.gd)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = true

func _on_hurtbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = false
