extends Node

# Map animations
var MapAnimations = preload("res://Scripts/MapAnimations.gd").new()

# Player sprites
const red_player = preload("res://GameObject/Player/Player.tscn")
const green_player = preload("res://GameObject/Player/GreenPlayer.tscn")
const blue_player = preload("res://GameObject/Player/BluePlayer.tscn")
const gray_player = preload("res://GameObject/Player/GrayPlayer.tscn")

@export var connected_controllers = {}
@export var player_slots = [true, true, true, true]
@export var player_models = [null, null, null, null]
var player_information = {
	"Player 1": {
		"alive": true,
		"playing": false,
		"model": null,
		"score": 0,
		"color": "Red",
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 2": {
		"alive": true,
		"playing": false,
		"model": null,
		"score": 0,
		"color": "Green",
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 3": {
		"alive": true,
		"playing": false,
		"model": null,
		"score": 0,
		"color": "Blue",
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 4": {
		"alive": true,
		"playing": false,
		"model": null,
		"score": 0,
		"color": "Gray",
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
}


# !!!
# I sincerily apologize for what yu'oure eyes are about to witness
# !!!


func GetScore(player: int):
	return player_information["Player " + str(player + 1)]["score"]
	
	
func SetScore(player: int, score: int):
	player_information["Player " + str(player + 1)]["score"] = score


func IsAlive(player: int):
	return player_information["Player " + str(player + 1)]["alive"]


func PlayerSpawningShenanigans(spawn_points):
	# Map Animations
	add_child(MapAnimations)
	
	var amiwitos = []
	
	# Spawn all players to the scene
	for i in Controls.player_information.keys():
		var playerinfo = Controls.player_information[i]
		
		if not playerinfo["playing"]:
			continue
		
		match playerinfo.color:
			"Red":
				var avi = red_player.instantiate()
				print("Red player instantiated")
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Green":
				var avi = green_player.instantiate()
				print("Green player instantiated")				
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Blue":
				var avi = blue_player.instantiate()
				print("Blue player instantiated")								
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Gray":
				var avi = gray_player.instantiate()
				print("Gray player instantiated")												
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
	
	player_models = MapAnimations.SpawnPlayers(amiwitos, spawn_points)


func NukeEverything():
	connected_controllers = {}
	player_slots = [true, true, true, true]
	player_models = [null, null, null, null]
	player_information = {
	"Player 1": {
		"playing": false,
		"color": "Red",
		"model": null,
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 2": {
		"playing": false,
		"color": "Green",
		"model": null,
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 3": {
		"playing": false,
		"color": "Blue",
		"model": null,
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
	"Player 4": {
		"playing": false,
		"color": "Gray",
		"model": null,
		"controller": {
			"id": 0,
			"name": "",
			"guid": "",
		}
	},
}
