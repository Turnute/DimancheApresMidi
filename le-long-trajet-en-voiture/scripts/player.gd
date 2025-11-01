extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite2D
@export var JUMP_VELOCITY = -250.0
#the jump count
var jump_count = 0
@export var max_jumps = 2


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		animated_sprite.play("idle")
		jump_count = 0
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	move_and_slide()
