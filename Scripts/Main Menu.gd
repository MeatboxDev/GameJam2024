extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/PlayerSelect/player_selection.tscn")

# Called when pressing the Quit button on the Main Menu
func _on_quit_button_pressed():
	get_tree().quit()



func _on_options_button_2_pressed():
	$Credits.show()


func _on_credits_pressed():
	$Credits.hide()
