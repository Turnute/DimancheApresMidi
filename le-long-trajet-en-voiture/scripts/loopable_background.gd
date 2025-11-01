extends Node2D

@export var speed_ref: NodePath    # pointe vers le noeud qui expose get_speed() (ex: "../Game")

var _game: Node
var _parts: Array[Node2D] = []
var _segment_w: float = 0.0

func _ready() -> void:
	_game = get_node_or_null(speed_ref)
	# Récupère les deux morceaux (A et B)
	for n in get_children():
		if n is Node2D:
			_parts.append(n)
	_parts.sort_custom(func(a,b): return a.position.x < b.position.x)
	# Déduit la largeur d'un segment depuis le premier Sprite2D
	var s := _parts[0] as Sprite2D
	_segment_w = s.texture.get_size().x * s.scale.x
	# S'assure que B est bien à droite de A
	if _parts.size() == 2:
		_parts[1].position.x = _parts[0].position.x + _segment_w

func _process(delta: float) -> void:
	var speed
	if _game and "get_speed" in _game:
		speed = _game.get_speed()

	for p in _parts:
		p.position.x -= speed / 3
		# Quand un morceau sort entièrement à gauche, on le téléporte à droite de l'autre
		if p.position.x <= -_segment_w:
			p.position.x += _segment_w * _parts.size()
