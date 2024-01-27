extends Node

var weapon:Area2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("jump")):
		for i in get_parent().find_child("Hold").get_overlapping_areas():
			if (i.is_in_group("Holdable")):
				print("GET HELD LOSER")
	pass
