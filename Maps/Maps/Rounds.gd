extends Node

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

var stage
var players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stage = get_parent()
	players = stage.player_array
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var live_players = players.keys().filter(func(x): return x.alive).size()
	match (live_players):
		1:
			# Win Round Sequence
			
			# This works ???
			players[players.keys().filter(func(x): return x.alive)[0]] += 1
			for i in players: 
				i.alive = true
				i.visible = true
			MapAnimations.SpawnPlayers(players, stage.spawnPoints)
			pass
		0:
			# If somehow this happens, just restart round
			pass
		_:
			# Do nothing
			pass		
	pass
