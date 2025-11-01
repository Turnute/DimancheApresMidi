extends Area2D
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = get_parent().get_parent().get_speed()
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed / 10
	#pass

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	var score : int = get_parent().get_parent().get_score()
	print(score)
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	queue_free()
