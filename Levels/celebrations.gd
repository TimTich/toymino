class_name Celebrations
extends Node2D

@export var random_time: float
@export var confettis: Array[CPUParticles2D] = []
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = random_time

func start() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	for confetti in confettis:
		confetti.emitting = true
