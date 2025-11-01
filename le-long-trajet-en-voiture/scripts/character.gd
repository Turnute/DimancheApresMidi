extends Sprite2D

# Assigne tes textures ici ou via l'inspecteur
@export var texture_1: Texture2D = preload("res://assets/car/character/char1.png")
@export var texture_2: Texture2D = preload("res://assets/car/character/char2.png")

func _ready() -> void:
	# Texture 1 par défaut
	texture = texture_1

func swap_textures() -> void:
	texture = texture_2 if texture == texture_1 else texture_1
