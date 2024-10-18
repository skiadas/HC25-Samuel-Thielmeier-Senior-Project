extends CharacterBody2D

var SPEED = 100.0
var TACKLE_SPEED = 200.0  # Speed boost during tackle
var TACKLE_DURATION = 0.5  # Tackle duration in seconds
var last_direction = Vector2.ZERO
var enemy_in_range = false
var is_attacking = false
var is_tackling = false

var direction : Vector2 = Vector2.ZERO

# Imports the AnimationTree node as the variable animation_tree
@onready var animation_tree : AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	add_to_group("Player")

func _process(delta):
	update_animation_parameters()

@warning_ignore("unused_parameter")
func _physics_process(delta):
	# Prevent movement if player is attacking or tackling
	if is_attacking or is_tackling:
		velocity = Vector2.ZERO
	else:
		# Get input direction and move the character if not attacking or tackling
		# Keys mapped in Project -> Project Settings -> Input Map
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * SPEED

	if direction != Vector2.ZERO and not (is_attacking or is_tackling):
		last_direction = direction

	if is_tackling:
		# Move in the last direction during tackle
		velocity = last_direction * TACKLE_SPEED
	
	move_and_slide()

func update_animation_parameters():
	# Handle idle/walking animations
	if velocity == Vector2.ZERO and not is_attacking and not is_tackling:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
	
	# Handle the attack animation (swing)
	if Input.is_action_just_pressed("swing") and not is_attacking:
		is_attacking = true
		animation_tree["parameters/conditions/swing"] = true
		await get_tree().create_timer(0.5).timeout  # Wait for swing duration
		is_attacking = false
		animation_tree["parameters/conditions/swing"] = false

	# Handle the tackle animation
	if Input.is_action_just_pressed("tackle") and not is_tackling:
		is_tackling = true
		
		# Restrict tackle to 4 cardinal directions
		if abs(last_direction.x) > abs(last_direction.y):
			# Move horizontally (left or right)
			last_direction = Vector2(last_direction.x, 0).normalized()
		else:
			# Move vertically (up or down)
			last_direction = Vector2(0, last_direction.y).normalized()

		animation_tree["parameters/conditions/tackle"] = true
		await get_tree().create_timer(TACKLE_DURATION).timeout  # Wait for tackle duration
		is_tackling = false
		animation_tree["parameters/conditions/tackle"] = false

	# Update blend position (for direction in animations)
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/swing/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
	
	# Ensure tackle uses corrected direction (4 cardinal directions only)
	if is_tackling:
		animation_tree["parameters/tackle/blend_position"] = last_direction

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = true
		print("Getting attacked!")

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = false
		print("Enemy exited the hitbox!")
