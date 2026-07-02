class_name PlacementChecker
extends Area2D

@export var isReverse := false
var isLegal := false

signal stateChanged()

var containingBodies: Array[Node2D] = []

func _ready() -> void:
	if isReverse:
		isLegal = !isLegal

func _on_body_entered(body: Node2D) -> void:
	containingBodies.append(body)
	check_legality()
	stateChanged.emit()

func _on_body_exited(body: Node2D) -> void:
	var index = containingBodies.find(body)
	containingBodies.remove_at(index)
	check_legality()
	stateChanged.emit()

func check_legality() -> void:
	if isReverse:
		print(containingBodies)
	isLegal = containingBodies.is_empty() if isReverse else not containingBodies.is_empty()
