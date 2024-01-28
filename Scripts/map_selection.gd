extends Node2D

# Map animations
var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

@export var connected_controllers = Controls.connected_controllers
@export var player_slots = Controls.player_slots
@export var player_models = Controls.player_models

const spawn_points = [
	Vector2(300, 700),
	Vector2(600, 700),
	Vector2(1000, 700),
	Vector2(1200, 700),
]

# Bandaid fix
var left_first = true
var right_first = true
var select_count = 0

# Scenes
const cavemap_scene = "res://Maps/Maps/cave_map.tscn"
const beachmap_scene = "res://Maps/Maps/beach_map.tscn"
const factorymap_scene = "res://Maps/Maps/cave_map.tscn"

# Previews
const cavemap_preview = preload("res://Assets/MapPreviews/Cavemap_Preview.png")
const beachmap_preview = preload("res://Assets/MapPreviews/Beachmap_Preview.png")
const factorymap_preview = preload("res://Assets/MapPreviews/Factorymap_Preview.png")

var preview_index = 0
const maps = [cavemap_preview, beachmap_preview, factorymap_preview]

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
			get_tree().change_scene_to_file(cavemap_scene)
			
		beachmap_preview:
			get_tree().change_scene_to_file(beachmap_scene)
			
		factorymap_preview:
			get_tree().change_scene_to_file(factorymap_scene)


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
