extends Node2D

# Game variables
#const PLAYER_START_POS := Vector2i(-100, -7)
#const CAM_START_POS := Vector2i(0, -50)

var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25

var score : int = 0

@export var ground_scroll_speed : float
@export var background_scroll_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	#resets the nodes
	#$Player.position = PLAYER_START_POS
	#$Player.velocity = Vector2i(0, 0)
	#$Camera2D.position = CAM_START_POS
	#$"LE SOL".position = Vector2i(0, 0)
	speed = START_SPEED
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score += speed
	pass

func get_score() -> int :
	return score

func get_speed() -> float :
	return speed
