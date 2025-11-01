extends Node2D
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = get_parent().get_speed()
	position.x -= speed / 10
	#pass
