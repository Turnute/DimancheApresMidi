extends Area2D

@export var speed_source: NodePath

var _game: Node

func _ready() -> void:
	_game = get_node_or_null(speed_source)
	# Si non défini, on tente de remonter dans l'arbre (fragile, mais utile par défaut)
	if _game == null and get_parent() and get_parent().get_parent():
		_game = get_parent().get_parent()

func _process(delta: float) -> void:
	var s := _get_speed()
	position.x -= s * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	var sc := _get_score()
	print(sc)
	game_over()

func _on_timer_timeout() -> void:
	queue_free()

func _get_speed() -> float:
	if _game and _game.has_method("get_speed"):
		return float(_game.get_speed())
	return 0.0

func _get_score() -> int:
	if _game and _game.has_method("get_score"):
		return int(_game.get_score())
	return 0

func game_over() -> void:
	if _game:
		_game.game_over()
