extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action("start"):
		call_deferred("queue_free")

func _on_toy_checker_area_exited(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent is Toy:
		area_parent.handle_legality()
