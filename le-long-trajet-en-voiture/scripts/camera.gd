extends Camera2D

@export var target: NodePath
@export var start_zoom: Vector2 = Vector2(4.45, 4.45)
@export var end_zoom:   Vector2 = Vector2(5.6, 5.6)
@export var duration: float = 5.5
@export var move_to_target: bool = true

var _init_pos: Vector2
var _init_zoom: Vector2
var _tw: Tween

var _rng := RandomNumberGenerator.new()
var _shake_time := 0.0
var _shake_duration := 0.0
var _shake_amp := 0.0           # en pixels
var _shake_original_offset := Vector2.ZERO

func _ready() -> void:
	_rng.randomize()
	_init_pos = global_position
	_init_zoom = start_zoom
	zoom = start_zoom
	_shake_original_offset = offset
	zoom_to_target()  # si tu veux auto-zoom au start

func _process(delta: float) -> void:
	if _shake_time < _shake_duration:
		_shake_time += delta
		var t := 1.0 - (_shake_time / _shake_duration)
		var a := _shake_amp * t * t         # damping (ease-out quad)
		offset = _shake_original_offset + Vector2(
			_rng.randf_range(-a, a),
			_rng.randf_range(-a, a)
		)
	else:
		offset = _shake_original_offset

func _make_tween(dur: float) -> Tween:
	if is_instance_valid(_tw):
		_tw.kill()
	_tw = create_tween()
	_tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_tw.set_parallel(true)
	return _tw

func zoom_to_node(n: Node2D, dur: float = duration) -> void:
	var tw := _make_tween(dur)
	tw.tween_property(self, "zoom", end_zoom, dur)
	if move_to_target:
		tw.tween_property(self, "global_position", n.global_position, dur)

func zoom_to_target(dur: float = duration) -> void:
	var n := get_node_or_null(target)
	if n is Node2D:
		zoom_to_node(n as Node2D, dur)

func reset_camera(dur: float = duration) -> void:
	var tw := _make_tween(dur)
	tw.tween_property(self, "zoom", _init_zoom, dur)
	tw.tween_property(self, "global_position", _init_pos, dur)

func screen_shake(intensity: int, duration: float = 0.25) -> void:
	_shake_amp = float(intensity)     # pixels max
	_shake_duration = duration
	_shake_time = 0.0
