extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var JUMP_VELOCITY = -300
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
		jump(JUMP_VELOCITY)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	move_and_slide()

func jump(VEL : int) -> void:
		animated_sprite.play("jump")
		velocity.y = VEL
		jump_count += 1
