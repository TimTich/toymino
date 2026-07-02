class_name Car
extends RigidBody2D

@export var speed := 100.00
var isActivated := false

var default_layer: int
var default_mask: int
var isInPlay := false
var isHeld := false

@export var colliders: Array[CollisionShape2D]
@onready var detection_area: Area2D = %DetectionArea
@export var placementCheckers: Array[PlacementChecker]
var isLegal := false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	default_layer = collision_layer
	default_mask = collision_mask
	check_legality()
	handle_legality()

func enter_play():
	isInPlay = true
	for collider in colliders:
		collider.disabled = false
	detection_area.monitoring = false
	freeze = false

func _physics_process(_delta: float) -> void:
	if isHeld and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_global_mouse_position()
	else:
		release_toy()
	
	if isActivated:
		apply_force(Vector2(speed, 0))

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Domino:
		print(str(body))
		isActivated = true

func release_toy() -> void:
	isHeld = false
	collision_layer = default_layer
	collision_mask = default_mask

func hold_toy() -> void:
	isHeld = true
	collision_layer = 0
	collision_mask = 0

func check_legality() -> void:
	for placementChecker in placementCheckers:
		if not placementChecker.isLegal:
			isLegal = false
			return
	isLegal = true

func handle_legality() -> void:
	if isLegal:
		self.modulate.r = 0
	else:
		self.modulate.r = 255

func _on_placement_checker_state_changed() -> void:
	if not isInPlay:
		check_legality()
		handle_legality()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		enter_play()
	if event is InputEventMouseButton and not isInPlay:
		if event.is_released():
			check_legality()
			handle_legality()


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and not isInPlay:
				hold_toy()
