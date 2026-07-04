class_name Car
extends Toy

@export var speed := 500.00
@export var activationTime := 1.5
@export var activationTimer: Timer
var isActivated := false

@export var rigidbody: RigidBody2D

@onready var detection_area: Area2D = %DetectionArea
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	super()
	activationTimer.wait_time = activationTime
	activationTimer.timeout.connect(deactivate)

func enter_play() -> void:
	super()
	detection_area.monitoring = true
	rigidbody.freeze = false

func _input(event: InputEvent) -> void:
	super(event)
	if event.is_action_pressed("ui_cancel"):
		rigidbody.apply_force(Vector2(speed * 10, 0))

func activate() -> void:
	isActivated = true
	audio_stream_player_2d.play()
	activationTimer.start()
	rigidbody.add_constant_force(Vector2(speed, 0))

func deactivate() -> void:
	rigidbody.constant_force = Vector2(0, 0)

func _on_detection_area_body_entered(_body: Node2D) -> void:
	if _body == self or isActivated:
		return
	activate()
