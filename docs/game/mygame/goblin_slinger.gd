extends CharacterBody2D

var speed = 50
var last_direction = Vector2.ZERO
var animated_sprite
var direction_change_timer = 0
var direction_change_interval = 5

func _ready():
	animated_sprite = $AnimatedSprite2D
	# Picks a random direction for the sprite to start in
	pick_random_direction()
	
func _physics_process(delta):
	# counting the time since start
	direction_change_timer += delta
	if direction_change_timer >= direction_change_interval:
		pick_random_direction() # Changes direction after timer reaches 5 seconds
		direction_change_timer = 0 # Resets timer
	
	velocity = last_direction * speed
	
		
	if last_direction.x < 0:
		animated_sprite.play("walk_left")
	elif last_direction.x > 0:
		animated_sprite.play("walk_right")
	elif last_direction.y < 0:
		animated_sprite.play("walk_up")
	elif last_direction.y > 0:
		animated_sprite.play("walk_down")
	else:
		animated_sprite.play("idle_down")
		
	move_and_slide()

# Picks a random direction for enemy
func pick_random_direction():
	var new_direction = Vector2.ZERO
	#Ensure that the direction is never a zero vector
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction # Update last direction variable
