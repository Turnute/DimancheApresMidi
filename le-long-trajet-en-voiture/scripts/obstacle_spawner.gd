extends Node2D

@onready var spawn_pos: Node2D = $SpawnLocation
@onready var timer: Timer = $SpawnTimer

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	timer.start()

func _spawn_one() -> void:
	var i := rng.randi_range(1, 16)
	var path := "res://scenes/obstacles/obstacle%d.tscn" % i
	var scene: PackedScene = load(path)
	if scene == null:
		push_warning("Obstacle introuvable: %s" % path)
		return

	var obstacle := scene.instantiate()
	obstacle.position = spawn_pos.position
	add_child(obstacle)

	timer.wait_time = rng.randf_range(1.0, 4.5)
	if timer.one_shot:
		timer.start()

func _on_spawn_timer_timeout() -> void:
	_spawn_one()
