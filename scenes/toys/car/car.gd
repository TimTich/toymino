class_name Car
extends Toy

@export var speed := 100.00
var isActivated := false

@export var rigidbody: RigidBody2D

@onready var detection_area: Area2D = %DetectionArea

func enter_play() -> void:
	super()
	for checker in placementCheckers:
		checker.monitoring = false
	detection_area.monitoring = true
	rigidbody.freeze = false

#func _physics_process(_delta: float) -> void:
	#if isActivated:
		#rigidbody.add_constant_force(Vector2(speed, 0))

func _on_detection_area_body_entered(_body: Node2D) -> void:
	if _body == self:
		return
	isActivated = true
	rigidbody.add_constant_force(Vector2(speed, 0))
