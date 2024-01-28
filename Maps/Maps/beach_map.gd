extends Node2D

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

const spawnPoints = [
	Vector2(845, 200),
	Vector2(1500, 750)
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

	Controls.PlayerSpawningShenanigans(spawnPoints)

func _process(delta):
	if Input.is_action_just_pressed("debug_reload"):
		get_tree().reload_current_scene()
	if $MUSIC.playing==false:
		$MUSIC.play()
