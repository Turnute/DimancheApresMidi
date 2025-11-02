extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var JUMP_VELOCITY: float = -300.0
@export var max_jumps: int = 2

var _game: Node

var jump_count: int = 0
@onready var gravity: float = float(ProjectSettings.get_setting("physics/2d/default_gravity"))

func _ready() -> void:
	_game = get_parent()

func _physics_process(delta: float) -> void:
	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Au sol : remet le compteur de sauts et anime idle
		if animated_sprite:
			animated_sprite.play("idle")
		jump_count = 0

	# Saut (multi-sauts)
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		jump(JUMP_VELOCITY)

	# Quitter le jeu (nécessite l'action "quit" mappée dans Input Map)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	move_and_slide()

func jump(vel: float) -> void:
	if animated_sprite:
		animated_sprite.play("jump")
	velocity.y = vel
	jump_count += 1
	_game.play_jump()

func die() -> void:
	if animated_sprite:
		animated_sprite.play("death")
	velocity = Vector2(JUMP_VELOCITY, JUMP_VELOCITY)
	await animated_sprite.animation_finished
	queue_free()
