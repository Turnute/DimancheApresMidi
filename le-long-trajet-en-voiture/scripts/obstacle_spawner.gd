extends Node2D

@onready var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")
@onready var spawn_pos: Node2D = $SpawnLocation
@onready var timer: Timer = $SpawnTimer

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	timer.start()

func _spawn_one() -> void:
	var obstacle := obstacle_scene.instantiate()
	obstacle.position = spawn_pos.position
	add_child(obstacle)
	# Randomise l'intervalle du prochain spawn
	timer.wait_time = rng.randf_range(1.0, 4.5)

func _on_spawn_timer_timeout() -> void:
	_spawn_one()
