extends Node

var weapon:Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func hold() -> Node2D:
	if (weapon != null): return weapon
	for i in get_parent().find_child("Hold").get_overlapping_areas():
		if (i.is_in_group("Holdable")):
			return i.get_parent()
	return null
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (weapon != null):
		weapon.position = get_parent().position
		if Input.is_action_just_pressed("debug_action"):
			weapon.find_child("Activate").Activate(sign(get_parent().velocity))
	else:
		if Input.is_action_just_pressed("debug_action"):
			weapon = hold()
	pass
