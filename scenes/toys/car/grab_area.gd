class_name GrabArea
extends Area2D

@export var target: Toy
var default_layer: int
var default_mask: int

var hasbeenGrabbed := false
var isGrabbing := false

func _ready() -> void:
	target.entered_play.connect(disable)
	default_layer = target.collision_layer
	default_mask = target.collision_mask

func disable() -> void:
	self.call_deferred("queue_free")

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		grab()
	if event.is_action_released("select"):
		release()
		if hasbeenGrabbed:
			target.handle_legality()

func _physics_process(_delta: float) -> void:
	if isGrabbing:
		target.global_position = get_global_mouse_position()

func grab() -> void:
	isGrabbing = true
	hasbeenGrabbed = true
	target.collision_layer = 0
	target.light_mask = 0

func release() -> void:
	isGrabbing = false
	target.collision_layer = default_layer
	target.collision_mask = collision_mask
