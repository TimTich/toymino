class_name Celebrations
extends Node2D

@export var random_time: float
@export var confettis: Array[CPUParticles2D] = []
@onready var timer: Timer = $Timer
@onready var audio_timer: Timer = $AudioTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	timer.wait_time = random_time

func start() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	for confetti in confettis:
		confetti.emitting = true
	_on_audio_timer_timeout()
	audio_timer.start()


func _on_audio_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = rng.randf_range(.8, 1.2)
	audio_stream_player_2d.play()
