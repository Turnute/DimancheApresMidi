extends Node2D

var speed : float = 10.0

@onready var animation_player = $AnimationPlayer
var jeu = preload("res://scenes/game.tscn")

func _on_button_pressed():
	start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(jeu)

func _process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		start()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
func start() -> void :
	animation_player.play("startfade")
	$Timer.start()

func get_speed() -> float:
	return speed
