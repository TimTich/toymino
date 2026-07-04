class_name Toy
extends PhysicsBody2D

var placementCheckers: Array[PlacementChecker] = []

var isInPlay := false
signal entered_play

var isLegal := false

func _ready() -> void:
	for child in get_children():
		if child is PlacementChecker:
			placementCheckers.append(child)
			child.stateChanged.connect(_on_placement_checker_state_changed)
	check_legality()

func enter_play() -> void:
	isInPlay = true
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = false
	for checker in placementCheckers:
		checker.monitoring = false
	entered_play.emit()

func _input(event: InputEvent) -> void:
	if event.is_action("start"):
		if isLegal:
			enter_play()
		else:
			call_deferred("queue_free")

func check_legality() -> void:
	for placementChecker in placementCheckers:
		if not placementChecker.isLegal:
			isLegal = false
			return
	isLegal = true

func handle_legality() -> void:
	if isLegal:
		self.modulate.a = 1
	else:
		self.modulate.a = .25

func _on_placement_checker_state_changed() -> void:
	if not isInPlay:
		check_legality()
		handle_legality()
