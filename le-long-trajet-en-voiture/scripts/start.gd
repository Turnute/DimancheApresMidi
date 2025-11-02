extends Node2D

var speed: float = 100.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const GAME_PATH := "res://scenes/game.tscn"  # <- chemin, pas de preload

func _ready() -> void:
	$Timer.stop()
	$Timer.one_shot = true

func _on_button_pressed() -> void:
	start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		start()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func start() -> void:
	$SFXPlayer.play()
	animation_player.play("startfade")
	$Timer.start()

func _on_timer_timeout() -> void:
	# évite tout conflit de chargement pendant les callbacks
	call_deferred("_go_to_game")

func _go_to_game() -> void:
	get_tree().change_scene_to_file(GAME_PATH)

func get_speed() -> float:
	return speed
