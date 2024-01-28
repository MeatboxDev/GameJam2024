extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

const spawnPoints = [
	Vector2(285, 675),
	Vector2(560, 960),
	Vector2(1550, 625),
	Vector2(965, 415)
	]
var RoundSystem:Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Animations
	RoundSystem = find_child("RoundSystem")
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
	# Spawn players in the map
	for i in Controls.player_models:
		i.queue_free()
	Controls.PlayerSpawningShenanigans(spawnPoints)
	print("CURRENT PLAYER MODELS: ")
	print(Controls.player_models)
	for i in Controls.player_models:
		RoundSystem.players[i] = 0
	

func _process(delta):
	if Input.is_action_just_pressed("debug_reload"):
		get_tree().reload_current_scene()
	if $MUSIC.playing==false:
		$MUSIC.play()
