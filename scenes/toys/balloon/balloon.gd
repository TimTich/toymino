class_name Balloon
extends Toy

@export var rigidbody: RigidBody2D

func _ready() -> void:
	super()
	print(isLegal)

func enter_play() -> void:
	super()
	rigidbody.freeze = false
