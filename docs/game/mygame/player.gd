
extends CharacterBody2D
# Sets the move speed of the player (change to increase/decrease)
var SPEED = 100.0
# Declares the last direction as a variable to call
var last_direction = Vector2.ZERO
var animated_sprite
var enemy_in_range = false

# Is like the setup function in Arduino
func _ready():
	# refrences the AnimatedSprite2D player node as the animated_sprite variable
	animated_sprite = $AnimatedSprite2D
	add_to_group("Player")

func _physics_process(delta):
	# X is -1 if 'left' is pressed, 1 if 'right' is pressed, and 0 otherwise
	# Y is -1 if 'up' is pressed, 1 if 'down' is pressed, and 0 otherwise
	#
	# Mapped 'left' to 'A', 'right' to 'D', 'up' to 'W', and 'down' to 'S' in Project -> Project Settings -> Input Map
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * SPEED
	
	# Remembers last direction player was facing
	if direction != Vector2.ZERO:
		last_direction = direction

	# Handle attack input first
	if Input.is_action_pressed("swing"):
		# Play the attack animation based on last direction
		if last_direction.x < 0:
			animated_sprite.play("swing_left")
		elif last_direction.x > 0:
			animated_sprite.play("swing_right")
		elif last_direction.y < 0:
			animated_sprite.play("swing_up")
		elif last_direction.y > 0:
			animated_sprite.play("swing_down")
	else:
		# Handle movement input
		if direction.x < 0:
			animated_sprite.play("walk_left")
		elif direction.x > 0:
			animated_sprite.play("walk_right")
		elif direction.y < 0:
			animated_sprite.play("walk_up")
		elif direction.y > 0:
			animated_sprite.play("walk_down")
		else:
			# Handle idle based on last direction
			if last_direction.x < 0:
				animated_sprite.play("idle_left")
			elif last_direction.x > 0:
				animated_sprite.play("idle_right")
			elif last_direction.y < 0:
				animated_sprite.play("idle_up")
			elif last_direction.y > 0:
				animated_sprite.play("idle_down")
			
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = true
		print("Getting attacked!")
	
func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = false
		print("Enemy exited the hitbox!")
