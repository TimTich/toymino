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
