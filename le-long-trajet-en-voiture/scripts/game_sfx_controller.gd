extends Node2D

@onready var _sfx_player1: AudioStreamPlayer2D = $SFXPlayer1
@onready var _sfx_player2: AudioStreamPlayer2D = $SFXPlayer2

@export var argument1: AudioStream = preload("res://assets/sfx/argument1.wav")
@export var argument2: AudioStream = preload("res://assets/sfx/argument2.wav")
@export var bip: AudioStream = preload("res://assets/sfx/bip.wav")
@export var bump: AudioStream = preload("res://assets//sfx/bump.wav")
@export var jump: AudioStream = preload("res://assets/sfx/jump.wav")
@export var kaboom: AudioStream = preload("res://assets//sfx/kaboom.wav")
@export var scream: AudioStream = preload("res://assets//sfx/scream.wav")

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func _play_jump() -> void:
	_sfx_player1.stream = jump
	_sfx_player1.play()

func _play_death() -> void:
	_sfx_player1.stream = kaboom
	_sfx_player2.stream = scream
	_sfx_player1.play()
	_sfx_player2.play()

func _play_bump() -> void:
	_sfx_player2.stream = bump
	_sfx_player2.play()

func play_argument_and_wait() -> void:
	var argument: AudioStream
	var i : int = rng.randi_range(0,1)
	if i == 0:
		argument = argument1
		print("on joue le 1")
	if i == 1:
		argument = argument2
		print("on joue le 2")
	_sfx_player2.stream = argument
	_sfx_player2.play()
	await _sfx_player2.finished
