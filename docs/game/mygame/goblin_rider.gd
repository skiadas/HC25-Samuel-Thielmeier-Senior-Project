extends CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D
var speed = 50
var last_direction = Vector2.ZERO
var animated_sprite
var direction_change_timer = 0
var direction_change_interval = 3
var run_speed = 75
var run = false
var player = null
var player_in_range = false
var is_attacking


func _ready():
	# fixes error where enemy gets stuck on top of player head
	platform_floor_layers = false
	animated_sprite = $AnimatedSprite2D
	# Picks a random direction for the sprite to start in
	pick_random_direction()
	add_to_group("Enemy")
	
func _physics_process(delta):
	if run:
		var direction_to_player = (target_to_chase.global_position - global_position).normalized()
		navigation_agent.target_position = target_to_chase.global_position
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * run_speed
		update_animation(direction_to_player, true)
	else:
	# counting the time since start
		direction_change_timer += delta
		if direction_change_timer >= direction_change_interval:
			pick_random_direction() # Changes direction after timer reaches 5 seconds
			direction_change_timer = 0 # Resets timer
			
		velocity = last_direction * speed
		update_animation(last_direction, false)
	
	move_and_slide()

# Picks a random direction for enemy
func pick_random_direction():
	var new_direction = Vector2.ZERO
	#Ensure that the direction is never a zero vector
	while new_direction == Vector2.ZERO:
		new_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	new_direction = new_direction.normalized()
	last_direction = new_direction # Update last direction variable
	
func update_animation(direction, run):
	if is_attacking:
		velocity = direction
	if not is_attacking:
		velocity = direction * speed
	if player_in_range and run:
		if abs(direction.x) > abs(direction.y):
			if direction.x < 0:
				animated_sprite.play("attack_left")
			elif direction.x > 0:
				animated_sprite.play("attack_right")
		else:
			if direction.y < 0:
				animated_sprite.play("attack_up")
			elif direction.y > 0:
				animated_sprite.play("attack_down")
	else:
		if direction.x < 0:
			animated_sprite.play("fly_left")
		elif direction.x > 0:
			animated_sprite.play("fly_right")
		elif direction.y < 0:
			animated_sprite.play("fly_up")
		elif direction.y > 0:
			animated_sprite.play("fly_down")

	


func _on_territory_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		run = true
		update_animation(last_direction, run)


func _on_territory_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		run = false
		pick_random_direction()
		update_animation(last_direction, run)
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		is_attacking = true
		print("Attacking")
		update_animation(last_direction, run)



func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		is_attacking = false
		print("Player exited hitbox")
		update_animation(last_direction, run)
