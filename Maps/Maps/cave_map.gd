extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

var RoundSystem:Node
const player_scene = preload("res://GameObject/Player/Player.tscn")
# const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Animations
	RoundSystem = find_child("RoundSystem")
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
	# Amiguitos
	var player1 = player_scene.instantiate()
	
	#await MapAnimations.PanoramicAnimation()
	await MapAnimations.PlayerSpawnAnimation(player1, Vector2(300, 300))
	
	# Add all unique controllers we can detect
	var connected_controllers = []
	print("Controllers ID:")
	for i in Input.get_connected_joypads():
		var new_controller = true
		print(Input.get_joy_guid(i))
		for j in connected_controllers:
			if Input.get_joy_guid(i) == Input.get_joy_guid(j):
				new_controller = false
				break
		if new_controller:
			connected_controllers.append(i)
	
	print("%d Controllers Connected" % connected_controllers.size())
	for i in connected_controllers:
		print("#%d: %s" % [i, Input.get_joy_name(i)])
		
		# Add a player per controller
		# Probably will remove later
		#var player = player_scene.instantiate()
		#player.player_index = i
		#player.position = Vector2(500, 0)
		#add_child(player)

func _process(delta):
	if Input.is_action_just_pressed("debug_reload"):
		get_tree().reload_current_scene()
	if $CaveMusic.playing==false:
		$CaveMusic.play()
