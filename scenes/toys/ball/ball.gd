class_name Ball
extends Toy

@export var rigidbody: RigidBody2D

func enter_play() -> void:
	super()
	rigidbody.freeze = false
