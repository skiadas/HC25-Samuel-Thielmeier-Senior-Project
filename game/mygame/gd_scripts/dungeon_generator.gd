extends Node2D

@onready var tile_map_layer = $TileMapLayer

var floor_tile := Vector2i(1, 0)
var wall_tile := Vector2i(0, 0)


const width = 80
const height = 60
const cell_size = 10
const min_room_size = 10
const max_room_size = 15
const max_rooms = 10

var grid = []
var rooms = []

var player_scene = preload("res://scenes/player.tscn")  # Load the player scene path here

func _ready():
	randomize()
	initialize_grid()
	generate_dungeon()
	draw_dungeon()
	load_player_in_first_room()

# Initialize grid with walls
func initialize_grid():
	for x in range(width):
		grid.append([])  # Initialize the grid
		for y in range(height):
			grid[x].append(1)  # Fill the grid with walls (represented by 1)
	print("Grid initialized.")  # Debugging

# Generate dungeon with rooms and corridors
func generate_dungeon():
	for i in range(max_rooms):
		var room = generate_room()
		if place_room(room):
			if rooms.size() > 0:
				connect_rooms(rooms[-1], room)
			rooms.append(room)
	print("Dungeon generated with ", rooms.size(), " rooms.")  # Debugging

# Generate random room dimensions and position
func generate_room():
	var room_width = randi() % (max_room_size - min_room_size + 1) + min_room_size
	var room_height = randi() % (max_room_size - min_room_size + 1) + min_room_size
	var x = randi() % (width - room_width - 1) + 1  # Ensure room fits in grid horizontally
	var y = randi() % (height - room_height - 1) + 1  # Ensure room fits in grid vertically
	return Rect2(x, y, room_width, room_height)

# Check if the room can fit and place it in the grid
func place_room(room):
	for x in range(room.position.x, room.position.x + room.size.x):
		for y in range(room.position.y, room.position.y + room.size.y):
			if grid[x][y] == 0:  # If the cell is already empty (0), it means the room can't be placed
				return false
	for x in range(room.position.x, room.position.x + room.size.x):
		for y in range(room.position.y, room.position.y + room.size.y):
			grid[x][y] = 0  # Mark room area as empty
	return true

# Connect rooms with corridors
func connect_rooms(room1, room2, corridor_width = 3):
	var start = Vector2(
		int(room1.position.x + room1.size.x / 2),
		int(room1.position.y + room1.size.y / 2)
	)
	var end = Vector2(
		int(room2.position.x + room2.size.x / 2),
		int(room2.position.y + room2.size.y / 2)
	)
	
	var current = start
	while current.x != end.x:
		current.x += 1 if end.x > current.x else -1
		for i in range(-int(corridor_width / 2), int(corridor_width / 2) + 1):
			for j in range(-int(corridor_width / 2), int(corridor_width / 2) + 1):
				if current.y + j >= 0 and current.y + j < height and current.x + i >= 0 and current.x + i < width:
					grid[current.x + i][current.y + j] = 0
	while current.y != end.y:
		current.y += 1 if end.y > current.y else -1
		for i in range(-int(corridor_width / 2), int(corridor_width / 2) + 1):
			for j in range(-int(corridor_width / 2), int(corridor_width / 2) + 1):
				if current.y + j >= 0 and current.y + j < height and current.x + i >= 0 and current.x + i < width:
					grid[current.x + i][current.y + j] = 0

# Draw the dungeon based on the grid
func draw_dungeon():
	if tile_map_layer.tile_set == null:
		print("TileSet not assigned!")
		return
	for x in range(width):
		for y in range(height):
			var tile_position = Vector2i(x, y)
			if grid[x][y] == 0:
				tile_map_layer.set_cell(tile_position, 0, floor_tile)  # Set floor tile
			else:
				tile_map_layer.set_cell(tile_position, 1, wall_tile)  # Set wall tile

# Function to load the player in the first room
func load_player_in_first_room():
	if rooms.size() > 0:
		var first_room = rooms[0]
		var spawn_x = randi() % int(first_room.size.x) + first_room.position.x
		var spawn_y = randi() % int(first_room.size.y) + first_room.position.y
		var player_instance = player_scene.instantiate()
		player_instance.position = Vector2(spawn_x * cell_size, spawn_y * cell_size)
		add_child(player_instance)
		print("Player spawned at: ", player_instance.position)  # Debugging
