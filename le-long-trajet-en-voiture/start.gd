extends Node2D

@onready var animation_player = $AnimationPlayer
var jeu = preload("res://scenes/game.tscn")

func _on_button_pressed():
	animation_player.play("startfade")
	$Timer.start()

func _on_timer_timeout() -> void:
	print("bjr :D")
	get_tree().change_scene_to_packed(jeu)
