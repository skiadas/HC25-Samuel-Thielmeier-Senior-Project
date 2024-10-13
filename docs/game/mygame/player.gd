extends CharacterBody2D

var SPEED = 100.0
var last_direction = Vector2.ZERO
var enemy_in_range = false
var is_attacking = false

var direction : Vector2 = Vector2.ZERO

@onready var animation_tree : AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	add_to_group("Player")

func _process(delta):
	update_animation_parameters()

@warning_ignore("unused_parameter")
func _physics_process(delta):
	# Prevent movement if player is attacking
	if is_attacking:
		velocity = Vector2.ZERO
	else:
		# Get input direction and move the character if not attacking
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * SPEED

	if direction != Vector2.ZERO and not is_attacking:
		last_direction = direction

	move_and_slide()

func update_animation_parameters():
	# Handle idle/walking animations
	if velocity == Vector2.ZERO and not is_attacking:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
	
	# Handle the attack animation (swing)
	if Input.is_action_just_pressed("swing") and not is_attacking:
		is_attacking = true
		animation_tree["parameters/conditions/swing"] = true
		await get_tree().create_timer(1.0).timeout  # Wait for 1 second (swing duration)
		is_attacking = false
		animation_tree["parameters/conditions/swing"] = false

	# Update blend position (for direction in animations)
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/swing/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = true
		print("Getting attacked!")

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = false
		print("Enemy exited the hitbox!")
