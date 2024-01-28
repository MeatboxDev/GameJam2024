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
@export var player_information = {
	"Player 1": {
		"alive": true,
		"playing": false,
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


func SetAlive(player: int, alive: bool):
	Controls.player_information["Player " + str(player + 1)]["alive"] = alive


func SetColor(player: int, color):
	Controls.player_information["Player " + str(player + 1)]["color"] = color


func GetColor(player: int):
	return Controls.player_information["Player " + str(player + 1)]["color"]


func GetController(player: int):
	return Controls.player_information["Player " + str(player + 1)]["controller"]


func SetController(player: int, controller):
	Controls.player_information["Player " + str(player + 1)]["controller"] = controller


func GetLivePlayers():
	var alive = 0
	for i in player_information.keys():
		if player_information[i]["alive"]:
			alive += 1
	return alive


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
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Green":
				var avi = green_player.instantiate()
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Blue":
				var avi = blue_player.instantiate()
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
				
			"Gray":
				var avi = gray_player.instantiate()
				avi.player_index = playerinfo["controller"].id
				amiwitos.append(avi)
	
	print("_____")
	print(MapAnimations.SpawnPlayers(amiwitos, spawn_points))


func NukeEverything():
	pass
	#connected_controllers = {}
	#player_slots = [true, true, true, true]
	#player_models = [null, null, null, null]
	#player_information = {
	#"Player 1": {
	#	"playing": false,
	#	"color": "Red",
	#	"controller": {
	#		"id": 0,
	#		"name": "",
	#		"guid": "",
	#	}
	#},
	#"Player 2": {
	#	"playing": false,
	#	"color": "Green",
	#	"controller": {
	#		"id": 0,
	#		"name": "",
	#		"guid": "",
	#	}
	#},
	#"Player 3": {
	#	"playing": false,
	#	"color": "Blue",
	#	"controller": {
	#		"id": 0,
	#		"name": "",
	#		"guid": "",
	#	}
	#},
	#"Player 4": {
	#	"playing": false,
	#	"color": "Gray",
	#	"controller": {
	#		"id": 0,
	#		"name": "",
	#		"guid": "",
	#	}
	#},
#}
