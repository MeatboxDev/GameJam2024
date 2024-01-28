extends Node

var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

var stage:Node2D
var players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stage = get_parent()
	players = stage.player_array
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var live_players = players.keys().filter(func(x): return x.alive).size()
	var final_score_text = ""
	for i in players.keys():
		final_score_text = str("Player ", i.player_index, ": ", players[i], " | ") + final_score_text
	find_child("RichTextLabel").text = final_score_text
	match (live_players):
		1:
			# Win Round Sequence
			
			# This works ???
			players[players.keys().filter(func(x): return x.alive)[0]] += 1
			for i in players: 
				i.alive = true
				i.visible = true
				if i.find_child("HoldingScript").weapon != null: 
					i.find_child("HoldingScript").weapon.queue_free()
					i.find_child("HoldingScript").weapon = null
			MapAnimations.SpawnPlayers(players, stage.spawnPoints)
			for i in stage.get_children().filter(func(x): return x.is_in_group("Projectile") or x.is_in_group("Explosion")):
				i.queue_free()
		0:
			for i in players: 
				i.alive = true
				i.visible = true
				if i.find_child("HoldingScript").weapon != null: 
					i.find_child("HoldingScript").weapon.queue_free()
					i.find_child("HoldingScript").weapon = null
			MapAnimations.SpawnPlayers(players, stage.spawnPoints)
		_:
			pass
	pass
