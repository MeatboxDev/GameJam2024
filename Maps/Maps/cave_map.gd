extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

const player_scene = preload("res://GameObject/Player/Player.tscn")
# const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Animations
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
	await MapAnimations.FadeIn(0.5)
	await MapAnimations.wait(2.0)
	#await MapAnimations.PanoramicAnimation()
	
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
		player.position = Vector2(500, 0)
		add_child(player)


func _process(delta):
	if $CaveMusic.playing==false:
		$CaveMusic.play()
