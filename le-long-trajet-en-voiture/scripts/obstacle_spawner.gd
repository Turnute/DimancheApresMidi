extends Node2D

@onready var obstacle = preload("res://scenes/obstacle.tscn")
@onready var spawn_pos = $SpawnLocation
@onready var timer = $SpawnTimer

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
		if timer.time_left < 0.01:
			timeout()

func timeout():
	var obstacleInstance = obstacle.instantiate()
	obstacleInstance.position = spawn_pos.position
	add_child(obstacleInstance)
	timer.wait_time = randf_range(1, 4.5)
	#print(timer.wait_time)
