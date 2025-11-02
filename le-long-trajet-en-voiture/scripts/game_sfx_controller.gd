extends Node2D

@onready var _sfx_player1: AudioStreamPlayer2D = $SFXPlayer1
@onready var _sfx_player2: AudioStreamPlayer2D = $SFXPlayer2

@export var bip: AudioStream = preload("res://assets/sfx/bip.wav")
@export var bump: AudioStream = preload("res://assets//sfx/bump.wav")
@export var jump: AudioStream = preload("res://assets/sfx/jump.wav")
@export var kaboom: AudioStream = preload("res://assets//sfx/kaboom.wav")
@export var scream: AudioStream = preload("res://assets//sfx/scream.wav")

func _play_jump() -> void:
	_sfx_player1.stream = jump
	_sfx_player1.play()

func _play_death() -> void:
	_sfx_player1.stream = kaboom
	_sfx_player2.stream = scream
	_sfx_player1.play()
	_sfx_player2.play()
