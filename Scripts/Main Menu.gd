extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/map_selection.tscn")

# Called when pressing the Quit button on the Main Menu
func _on_quit_button_pressed():
	get_tree().quit()


