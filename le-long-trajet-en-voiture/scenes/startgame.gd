extends Node2D

@onready var animation_player = $AnimationPlayer
var jeu = preload("res://scenes/game.tscn")

func _on_button_pressed():
	animation_player.play("startfade")


func _on_animation_player_animation_finished():
	get_tree().change_scene_to_packed(jeu)
