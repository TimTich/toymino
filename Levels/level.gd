class_name Level
extends Node

@export var objectsNode: Node
var dominos: Array[Domino] = []

@export var celebrations: Array[Celebrations] = []

signal level_complete()
@onready var juichen: AudioStreamPlayer2D = $Juichen

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
	for celebration in celebrations:
		celebration.start()
