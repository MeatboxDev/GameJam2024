extends Node

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

var stage
var players = []
var player_scores = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stage = get_parent()
	players = stage.player_array
	for i in players: player_scores[i] = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var live_players = players.filter(func(x): return x.alive).size()
	match (live_players):
		1:
			# Win Round Sequence
			
			# This works ???
			player_scores[players.filter(func(x): return x.alive)[0]] += 1
			for i in players: i.alive = true
			MapAnimations.SpawnPlayers(players, stage.spawnPoints)
			pass
		0:
			# If somehow this happens, just restart round
			pass
		_:
			# Do nothing
			pass		
	pass
