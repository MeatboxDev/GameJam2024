extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

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
	#RoundSystem = find_child("RoundSystem")
	add_child(MapAnimations)
	MapAnimations.camera = $MapCamera
	
	# Spawn players in the map
	Controls.PlayerSpawningShenanigans(spawnPoints)

func _process(delta):
	if Input.is_action_just_pressed("debug_reload"):
		get_tree().reload_current_scene()
	if $MUSIC.playing==false:
		$MUSIC.play()
