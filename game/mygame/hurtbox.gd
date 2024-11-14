extends Area2D

var facing_direction = Vector2.RIGHT  # Default facing direction
var offset_distance = 15  # Distance from the player

func update_position():
	# Move the hurtbox based on the facing direction
	match facing_direction:
		Vector2.RIGHT:
			position = Vector2(offset_distance, 0)
		Vector2.LEFT:
			position = Vector2(-offset_distance, 0)
		Vector2.UP:
			position = Vector2(0, -offset_distance)
		Vector2.DOWN:
			position = Vector2(0, offset_distance)
