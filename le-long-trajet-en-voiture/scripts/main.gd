extends Node2D

var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25
const SWAP_THRESHOLD := 5000	

var score : float = 0.0
var _did_swap := false

@export var ground_scroll_speed : float
@export var background_scroll_speed : float

func _ready() -> void:
	rng.randomize()
	new_game()
	

func new_game():
	speed = START_SPEED
	score = 0.0
	_did_swap = false

func _process(delta: float) -> void:
	score += speed * delta * 10.5  # frame-rate indépendant
	show_score()
	if not _did_swap and score >= SWAP_THRESHOLD:
		$car/character.swap_textures()
		_did_swap = true

func show_score() -> void:
	$Camera2D/HUD.get_node("ScoreLabel").text = "SCORE: " + str(int(score))

func get_score() -> int:
	return int(score)

func get_speed() -> float:
	return speed

var rng := RandomNumberGenerator.new()

func _on_event_timer_timeout() -> void:
	$EventTimer.wait_time = rng.randf_range(20.0, 40.0)
	var ev: int = rng.randi_range(0, 0)
	match ev:
		0:
			# Event Pont
			pass
		#1:
		#	# Event Dispute
		#	pass
		#2:
		#	# Event Dos d'Âne
		#	pass
		#3:
		#	# Obstacle très proche de la voiture
		#	pass
		#4:
		#	# Autre event ?
		#	pass
		#5:
		#	# Autre event ?
		#	pass
		_:
			pass  # sécurité

var home = preload("res://scenes/start.tscn")

func _on_end_timer_timeout() -> void:
	print("coubeh")
	get_tree().change_scene_to_packed(home)

func game_over() -> void:
	print("Game Over!")
	# Lance l'animation de fin
	$GameOver.play("game_end")

	# Démarre le timer d'outro
	$GameOver/EndTimer.start()

	# Si ton animation met le jeu en pause, assure-toi que le EndTimer a Pause Mode = Process
	# await bloque proprement jusqu'au timeout
	await $GameOver/EndTimer.timeout

	# Change la scène (de façon robuste)
	get_tree().call_deferred("change_scene_to_packed", home)
