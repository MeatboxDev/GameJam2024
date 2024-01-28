extends Node2D

# Map animations
var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

# Bandaid fix
var left_first = true
var right_first = true
var select_count = 0

# Player sprites
const player_scene = preload("res://GameObject/Player/Player.tscn")
# const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")

# Scenes
const cavemap_scene = "res://Maps/Maps/cave_map.tscn"
const beachmap_scene = "res://Maps/Maps/beach_map.tscn"

# Previews
const cavemap_preview = preload("res://Assets/MapPreviews/Cavemap_Preview.png")
const beachmap_preview = preload("res://Assets/MapPreviews/Beachmap_Preview.png")


var preview_index = 0
const maps = [cavemap_preview, beachmap_preview]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Map Animations
	add_child(MapAnimations)
	
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


func change_map(new_index: int):
	# Update the index value
	preview_index = new_index
	
	# Change sprite
	get_node("Television/Television_Sprite").texture = maps[preview_index % maps.size()]


func _on_select_button_area_body_entered(body):
	print("Select map")
	
	# Bandaid fix
	if select_count <= 2:
		select_count += 1
		return
		
	await MapAnimations.FadeOut(0.5)
		
	match maps[preview_index % maps.size()]:
		cavemap_preview:
			get_tree().change_scene_to_file(cavemap_scene)
			
		beachmap_preview:
			get_tree().change_scene_to_file(beachmap_scene)
			


func _on_left_button_area_body_entered(body):
	# Bandaid fix
	if left_first:
		left_first = false
		return
	
	print("Previous map")
	change_map(preview_index - 1)


func _on_right_button_area_body_entered(body):
	# Bandaid fix
	if right_first:
		right_first = false
		return
		
	print("Next map")
	change_map(preview_index + 1)

func _process(delta):
	if $MapSelectionMusic.playing==false:
		$MapSelectionMusic.play()
