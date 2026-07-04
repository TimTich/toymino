class_name Domino
extends RigidBody2D

@export var isFirst := false
@export var tipImpulse := Vector2(100, 0)
var isFallen := false
signal has_fallen(domino: Domino)
@export_range(0, 90) var fallThreshold := 40.0
@onready var check_fall_state_timer: Timer = %CheckFallStateTimer
@onready var tipping_point: Marker2D = %TippingPoint
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var rng := RandomNumberGenerator.new()

func _input(event: InputEvent) -> void:
	if event.is_action("start") and isFirst:
		tip_piece()

func tip_piece() -> void:
	var offset:= to_local(tipping_point.global_position)
	apply_impulse(tipImpulse, offset)

func check_fall_state() -> void:
	if abs(rotation_degrees) > fallThreshold:
		isFallen = true
		check_fall_state_timer.queue_free()
		audio_stream_player_2d.pitch_scale = rng.randf_range(0.5, 1.5)
		audio_stream_player_2d.play(.08)
		has_fallen.emit(self)
