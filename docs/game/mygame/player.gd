extends CharacterBody2D

# Sets the move speed of the player (change to increase/decrease)
var SPEED = 100.0

# Declares the last direction as a variable to call
var last_direction = Vector2.ZERO

var animated_sprite

func _ready():
	# refrences the AnimatedSprite2D player node as the animated_sprite variable
	animated_sprite = $AnimatedSprite2D

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
		
	if direction.x < 0:
		animated_sprite.play("walk_left")
	elif direction.x > 0:
		animated_sprite.play("walk_right")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	elif direction.y > 0:
		animated_sprite.play("walk_down")
	else:
		if last_direction.x < 0:
			animated_sprite.play("idle_left")
		elif last_direction.x > 0:
			animated_sprite.play("idle_right")
		elif last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
		
	move_and_slide()