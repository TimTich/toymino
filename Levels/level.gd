class_name Level
extends Node

@export var objectsNode: Node
var dominos: Array[Domino] = []

@export var celebrations: Array[Celebrations] = []

signal level_complete()
@onready var juichen: AudioStreamPlayer2D = $Juichen

@onready var btn = get_node("Objects/Reset")
@onready var btn2 = get_node("Objects/Advance")

func _ready() -> void:
	for child in objectsNode.get_children():
		if child is Domino:
			dominos.append(child)
			child.has_fallen.connect(handle_fallen_domino)

func handle_fallen_domino(domino: Domino) -> void:
	var index = dominos.find(domino)
	if index >= 0:
		dominos.remove_at(index)
	
	if dominos.size() == 0:
		juichen.play()
		level_complete.emit()
		celebrate()

func celebrate() -> void:
	btn2.visible = true
	btn.visible = false
	for celebration in celebrations:
		celebration.start()

func _input(event: InputEvent) -> void:
	if event.is_action("start"):
		btn.visible = true

func _on_reset_pressed():
	get_tree().reload_current_scene()

func _on_advance_pressed():
		get_tree().change_scene_to_file('res://Levels/level1.tscn')
