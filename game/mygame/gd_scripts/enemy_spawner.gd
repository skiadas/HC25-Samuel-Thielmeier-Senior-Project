extends Node2D
@export var enemy_scene = preload("res://scenes/goblin_rider.tscn")
@export var spawn_interval = 3.0
var spawn_timer = Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", Callable(self, "_on_spawner_timout"))
	add_child(spawn_timer)
	
func _on_spawner_timout():
	spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	get_parent().add_child(enemy)
