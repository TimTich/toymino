extends Control

var level = 1;

func _on_start_button_pressed():
	get_tree().change_scene_to_file('res://Levels/Level' + str(level) + '.tscn') #change to correct screen later
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_option_button_item_selected(index):
	level = index + 1
	pass # Replace with function body.


func _on_option_button_pressed():
	var popup = $OptionButton.get_popup()

	# Wait until Godot has positioned the popup.
	await get_tree().process_frame

	var pos = popup.position
	pos.x -= popup.size.x  + 59     # Move it to the left of the button.
	# Optional: align the top edges.
	pos.y = $OptionButton.global_position.y + 77

	popup.position = pos
