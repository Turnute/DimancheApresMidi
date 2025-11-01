extends Node2D

@export var speed_ref: NodePath    # Noeud qui expose get_speed() (ex: "../Game")

var _game: Node
var _parts: Array[Node2D] = []
var _segment_w: float = 0.0

func _ready() -> void:
	_game = get_node_or_null(speed_ref)
	# Récupère les morceaux (A, B, ...)
	for n in get_children():
		if n is Node2D:
			_parts.append(n)
	_parts.sort_custom(func(a, b): return a.position.x < b.position.x)

	_segment_w = _compute_segment_width()
	if _segment_w <= 0.0:
		push_warning("Impossible de déduire la largeur d’un segment. Vérifie la disposition ou la texture des éléments.")
	else:
		# S'assure que le 2e est bien à droite du 1er
		if _parts.size() >= 2:
			_parts[1].position.x = _parts[0].position.x + _segment_w

func _process(delta: float) -> void:
	var speed := 0.0
	if _game and _game.has_method("get_speed"):
		speed = float(_game.get_speed())

	for p in _parts:
		p.position.x -= speed * delta * 40
		# Quand un morceau sort entièrement à gauche, on le téléporte à droite de l'autre
		if p.position.x <= -_segment_w:
			p.position.x += _segment_w * _parts.size()

func _compute_segment_width() -> float:
	# Si deux morceaux existent déjà, on prend leur distance horizontale
	if _parts.size() >= 2:
		return abs(_parts[1].position.x - _parts[0].position.x)
	# Sinon, si c'est un Sprite2D, on déduit la largeur via la texture
	if _parts.size() == 1 and _parts[0] is Sprite2D:
		var s := _parts[0] as Sprite2D
		if s.texture:
			return s.texture.get_size().x * s.scale.x
	return 0.0
