extends Node

var players = []
var player_scores = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func RegisterPlayer(player_object:CharacterBody2D):
	players.append(player_object)
	player_scores[player_object] = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var live_players = players.filter(func(x): return x.alive).size()
	match (live_players):
		1:
			# Win Round Sequence
			
			# This works ???
			player_scores[players.filter(func(x): return x.alive)[0]] += 1
			pass
		0:
			# If somehow this happens, just restart round
			pass
		_:
			# Do nothing
			pass		
	pass
