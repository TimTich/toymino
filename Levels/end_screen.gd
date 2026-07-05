extends Node

@export var objectsNode: Node

@export var celebrations: Array[Celebrations] = []

@onready var juichen: AudioStreamPlayer2D = $Juichen

@onready var btn = get_node("Objects/Reset")
@onready var btn2 = get_node("Objects/Advance")

func _ready() -> void:
	btn2.visible = true
	for celebration in celebrations:
		celebration.start()

func _input(event: InputEvent) -> void:
	if event.is_action("start"):
		btn.visible = true

func _on_reset_pressed():
	get_tree().reload_current_scene()

func _on_advance_pressed():
		get_tree().change_scene_to_file('res://Levels/title_screen.tscn')
