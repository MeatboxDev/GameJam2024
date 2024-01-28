extends Node2D

# Map animations
var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

const spawn_points = [
	Vector2(100, 0),
	Vector2(300, 0),
	Vector2(1300, 0),
	Vector2(1500, 0),
]

# Bandaid fix
var left_first = true
var right_first = true
var select_count = 0

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
	# Animations
	#RoundSystem = find_child("RoundSystem")
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
	# Spawn my boyfriends
	Controls.PlayerSpawningShenanigans(spawn_points)

func change_map(new_index: int):
	# Update the index value
	preview_index = new_index
	
	# Change sprite
	get_node("Television/Television_Sprite").texture = maps[preview_index % maps.size()]


func _on_select_button_area_body_entered(body):
	print("Select map")
	
	# Bandaid fix
	if select_count < 1:
		select_count += 1
		return
		
	await MapAnimations.FadeOut(0.5)
		
	match maps[preview_index % maps.size()]:
		cavemap_preview:
			# Controls.NukeEverything()
			get_tree().change_scene_to_file(cavemap_scene)
			
		beachmap_preview:
			# Controls.NukeEverything()
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
