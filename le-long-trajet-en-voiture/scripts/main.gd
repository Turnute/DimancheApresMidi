extends Node2D

var speed: float
const START_SPEED: float = 100.0
const MAX_SPEED: float = 250.0
const SWAP_THRESHOLD := 5000.0
const HOME_PATH := "res://scenes/start.tscn"
var is_game_over := false

var score: float = 0.0
var _did_swap := false

@export var ground_scroll_speed: float
@export var background_scroll_speed: float

@onready var _score_label: Label = get_node_or_null("Camera2D/HUD/ScoreLabel")
@onready var _pannal: Sprite2D = get_node_or_null("Camera2D/HUD/magnifiquePannal")
@onready var _event_timer: Timer = $EventTimer
@onready var _end_timer: Timer = $EndTimer
@onready var _pan_timer: Timer = $PannalTimer
@onready var _character := get_node_or_null("car/character")
@onready var _audio_controller: Node2D = $AudioController
@onready var _bgm: AudioStreamPlayer2D = get_node_or_null("/root/Bgm")

var rng := RandomNumberGenerator.new()

var ev : int = -1

var home: PackedScene = preload("res://scenes/start.tscn")
var game_over_timer : float = 6.0

func _ready() -> void:
	rng.randomize()
	new_game()
	if is_instance_valid(_event_timer) and _event_timer.is_stopped():
		_event_timer.start()

	if _score_label:
		_score_label.modulate.a = 0.0
		var tw := create_tween()
		tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tw.tween_property(_score_label, "modulate:a", 1.0, 30.0)	

func new_game() -> void:
	speed = START_SPEED
	score = 0.0
	_did_swap = false

func _process(delta: float) -> void:
	if is_game_over:
		return

	score += speed * delta * 1.5
	show_score()

	if not _did_swap and score >= SWAP_THRESHOLD:
		if is_instance_valid(_character) and _character.has_method("swap_textures"):
			_character.swap_textures()
			_did_swap = true
	
	if speed < MAX_SPEED:
		speed += 0.5 * delta
		#print(speed)

func show_score() -> void:
	if _score_label:
		_score_label.text = "SCORE: %d" % int(score)

func get_score() -> int:
	return int(score)

func get_speed() -> float:
	return speed

func _on_event_timer_timeout() -> void:
	_event_timer.wait_time = rng.randf_range(25.0, 40.0)
	print(_event_timer.wait_time)
	ev = rng.randi_range(0,2)
	_pan_timer.start()
	_pannal.show_pannal(ev)

func game_over() -> void:
	if is_game_over:
		return
	is_game_over = true

	print("Game Over!")

	show_score()

	$GameOver.play("game_end")
	$Camera2D.screen_shake(12)
	$Camera2D.reset_camera(game_over_timer)
	$Player.die()
	_audio_controller._play_death()

	if _end_timer:
		_end_timer.one_shot = true
		_end_timer.start(game_over_timer)
		await _end_timer.timeout

	get_tree().change_scene_to_file(HOME_PATH)

func play_jump() -> void:
	_audio_controller._play_jump()
	$Camera2D.screen_shake(1)

func event_speed_bumb() -> void:
	if !is_game_over:
		$Player.jump(-800)
		$Camera2D.screen_shake(10)
		_audio_controller._play_bump()

func event_argument() -> void:
	$Camera2D.screen_shake(5)
	$Camera2D.reset_camera(1)

	if _bgm and _bgm.playing:
		_bgm.stream_paused = true

	await _audio_controller.play_argument_and_wait()

	if _bgm:
		_bgm.stream_paused = false
	
	if !is_game_over:
		$Camera2D.zoom_to_target(10)

func event_bridge() -> void:
	$AnimBridge.anim()

func _on_pannal_timer_timeout() -> void:
	_pannal.unload()
	_pan_timer.stop()
	_event_load()

func _event_load() -> void:
	match ev:
		0:
			event_speed_bumb()
		1:
			event_argument()
		2:
			event_bridge()
		-1:
			pass
	
