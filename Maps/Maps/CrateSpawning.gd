extends Node

@export var positions:Array = []
var used_positions:Array = []
var crates = []

const crate = preload("res://GameObject/Items/Hazards/Crate/Crate.tscn")

const frequency:int = 100
var timer:int = frequency

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if timer > 0: 
		timer -= 1
		return
	if crates.size() < 2:
		var selected_position = positions[randi_range(0,positions.size()-1)]
		while selected_position in used_positions:
			selected_position = positions[randi_range(0,positions.size()-1)]
		var crate_instance = crate.instantiate()
		add_child(crate_instance)
		crate_instance.position = selected_position
		crates.append(crate_instance)
		used_positions.append(selected_position)
	timer = frequency
	pass
