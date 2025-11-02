extends Node2D

@onready var brudge : AnimationPlayer = $AnimationPlayer

func anim() -> void:
	brudge.play("debuttunnel")
