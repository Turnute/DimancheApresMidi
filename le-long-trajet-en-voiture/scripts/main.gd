extends Node2D

var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25
const SWAP_THRESHOLD := 5000

var score : float = 0.0
var _did_swap := false

@export var ground_scroll_speed : float
@export var background_scroll_speed : float

enum events { BRIDGE, ARGUMENT }

func _ready() -> void:
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

func _on_event_timer_timeout() -> void:
	var env : int
	$EventTimer.wait_time = randf_range(20, 40)
	#env = (int)randf_range(0, 5)
	#match env:
	#	BRIDGE:
	pass # Replace with function body.
