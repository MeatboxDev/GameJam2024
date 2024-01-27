extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	const player_scene = preload("res://GameObject/Player/Player.tscn")
	const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")
	
	# Add all unique controllers we can detect
	var connected_controllers = []
	for i in Input.get_connected_joypads():
		var new_controller = true
		print(Input.get_joy_guid(i))
		for j in connected_controllers:
			if Input.get_joy_guid(i) == Input.get_joy_guid(j):
				new_controller = false
				break
		if new_controller:
			connected_controllers.append(i)
	
	print("%d connected controllers" % connected_controllers.size())
	for i in connected_controllers:
		print("#%d: %s" % [i, Input.get_joy_name(i)])
		
		# Add a player per controller
		# Probably will remove later
		var player = player_scene.instantiate()
		player.player_index = i
		add_child(player)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
