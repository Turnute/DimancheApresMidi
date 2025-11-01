extends Camera2D

@export var target: NodePath          # Le Node (Player, etc.) vers lequel on zoome
@export var start_zoom: Vector2 = Vector2(2.0, 2.0)   # Zoom de départ (plus grand = plus loin)
@export var end_zoom:   Vector2 = Vector2(1.0, 1.0)   # Zoom d'arrivée (1,1 = normal)
@export var duration: float = 1.2                     # Durée de l’animation (en secondes)
@export var move_to_target: bool = true               # Glisser la caméra vers la cible pendant le zoom ?

func _ready() -> void:
	zoom = start_zoom              # On part du zoom de départ

	var tw := create_tween()
	tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Anime le zoom vers la valeur finale
	tw.parallel().tween_property(self, "zoom", end_zoom, duration)

	# Optionnel : déplace la caméra pour se centrer sur la cible en même temps
	if move_to_target and target != NodePath(""):
		var n := get_node_or_null(target)
		if n is Node2D:
			tw.parallel().tween_property(self, "global_position", (n as Node2D).global_position, duration)

# TODO: ZOOM PLUS LENT A L'ARRET !!!
