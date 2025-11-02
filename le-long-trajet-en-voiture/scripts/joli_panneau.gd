extends Sprite2D

@export var texture_1: Texture2D = preload("res://assets/panneau/pannal1.png")
@export var texture_2: Texture2D = preload("res://assets/panneau/pannal2.png")
@export var texture_3: Texture2D = preload("res://assets/panneau/pannal3.png")

func _ready() -> void:
	visible = false

func show_pannal(i : int) -> void:
	print("panneau is")
	print(i)
	visible = true
	if i == 0:
		texture = texture_1
	elif i == 1:
		texture = texture_2
	elif i == 2:
		texture = texture_3

func unload() -> void:
	visible = false
