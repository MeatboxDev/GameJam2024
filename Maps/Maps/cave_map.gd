extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

var player_array = {}
const spawnPoints = [
	Vector2(285, 675),
	Vector2(560, 960),
	Vector2(1550, 625),
	Vector2(965, 415)
	]
var RoundSystem:Node
const player_scene = preload("res://GameObject/Player/Player.tscn")
# const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Animations
	RoundSystem = find_child("RoundSystem")
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
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
		var player = player_scene.instantiate()
		player.player_index = i
		player_array[player] = 0
	
	MapAnimations.SpawnPlayers(player_array, spawnPoints)

func _process(delta):
	if Input.is_action_just_pressed("debug_reload"):
		get_tree().reload_current_scene()
	if $CaveMusic.playing==false:
		$CaveMusic.play()
