extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_pressed():
	print("bye")
	get_tree().paused = false
	$Menu.hide()



func _on_pause_button_pressed():
	print("hi")
	get_tree().paused = true
	$Menu.show()
