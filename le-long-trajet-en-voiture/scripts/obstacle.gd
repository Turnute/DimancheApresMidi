extends Area2D
@export var speed = 0.3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hellooooo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed
	#pass


func _on_body_entered(body: Node2D) -> void:
	print("Ouch!")
	pass # Replace with function body.
