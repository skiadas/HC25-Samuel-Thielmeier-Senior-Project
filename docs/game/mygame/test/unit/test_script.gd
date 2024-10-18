extends GutTest
var player_scene = preload("res://Player.tscn")  # Load the player scene file


func test_player_moves_right():
	# Load the player scene instead of just the script
	var player = player_scene.instantiate()  # Create an instance of the player scene	add_child(player)  # Add to the scene so that physics and movement work
	add_child(player)
	# Simulate pressing the right key
	Input.action_press("right")
	player._physics_process(1.0)  # Simulate one frame of physics
	# Assert that the player is moving right (positive x-direction)
	assert_true(player.velocity.x > 0, "Player should move right")
	# Release the key
	Input.action_release("right")
	
func test_player_moves_left():
	# Load the player scene instead of just the script
	var player = player_scene.instantiate()  # Create an instance of the player scene	add_child(player)  # Add to the scene so that physics and movement work
	add_child(player)
	# Simulate pressing the left key
	Input.action_press("left")
	player._physics_process(1.0)  # Simulate one frame of physics
	# Assert that the player is moving left (negative x-direction)
	assert_true(player.velocity.x < 0, "Player should move left")
	# Release the key
	Input.action_release("left")

func test_player_moves_up():
	# Load the player scene instead of just the script
	var player = player_scene.instantiate()  # Create an instance of the player scene	add_child(player)  # Add to the scene so that physics and movement work
	add_child(player)
	# Simulate pressing the up key
	Input.action_press("up")
	player._physics_process(1.0)  # Simulate one frame of physics
	# Assert that the player is moving up (negative y-direction)
	assert_true(player.velocity.y < 0, "Player should move up")
	# Release the key
	Input.action_release("up")
	
func test_player_moves_down():
	# Load the player scene instead of just the script
	var player = player_scene.instantiate()  # Create an instance of the player scene	add_child(player)  # Add to the scene so that physics and movement work
	add_child(player)
	# Simulate pressing the down key
	Input.action_press("down")
	player._physics_process(1.0)  # Simulate one frame of physics
	# Assert that the player is moving up (positive y-direction)
	assert_true(player.velocity.y > 0, "Player should move down")
	# Release the key
	Input.action_release("down")
