class_name Ball
extends Toy

@export var rigidbody: RigidBody2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var played := false
var lastVel: Vector2 = Vector2.ZERO

func enter_play() -> void:
	super()
	rigidbody.freeze = false

func _physics_process(delta: float) -> void:
	if isInPlay:
		if rigidbody.linear_velocity.y < -50 and not played:
			audio_stream_player_2d.play(.1)
			played = true
		elif rigidbody.linear_velocity.y > 0 and played:
			played = false
