extends Node2D

@onready var obstacle = preload("res://scenes/obstacle.tscn")
@onready var spawn_pos = $SpawnLocation

func _ready() -> void:
	$SpawnTimer.start()
	print($SpawnTimer.time_left)

func _process(delta: float) -> void:
		#print($SpawnTimer.time_left)
		if $SpawnTimer.time_left < 0.01:
			timeout()

func timeout():
	print("Salam je vis")
	var obstacleInstance = obstacle.instantiate()
	obstacleInstance.position = spawn_pos.position
	add_child(obstacleInstance)
