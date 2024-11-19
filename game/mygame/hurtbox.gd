# Hurtbox script to change the position based on the direction the player/enemy is facing. Can be imported by
# right clicking on the hurtbox area2d node in whichever scene, then attatch script, and type "hurtbox.gd"

extends Area2D

var facing_direction = Vector2.RIGHT  # Default facing direction

func update_position(offset_distance):
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
