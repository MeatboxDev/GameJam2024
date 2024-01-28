extends Node2D

# Player Entries
const player1_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player1_Entry.tscn")
const player2_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player2_Entry.tscn")
const player3_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player3_Entry.tscn")
const player4_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player4_Entry.tscn")

# Player Models
const red_model = preload("res://Scenes/PlayerSelect/AnimatedAmiguitos/red_player.tscn")
const green_model = preload("res://Scenes/PlayerSelect/AnimatedAmiguitos/green_player.tscn")
const blue_model = preload("res://Scenes/PlayerSelect/AnimatedAmiguitos/blue_player.tscn")
const gray_model = preload("res://Scenes/PlayerSelect/AnimatedAmiguitos/gray_player.tscn")

const players = ["Red", "Green", "Blue", "Gray"]
const player_models = [red_model, green_model, blue_model, gray_model]

var p1_index = 0
var p2_index = 1
var p3_index = 2
var p4_index = 3

# Instantiate an entry for all players
var player1 = player1_entry.instantiate()
var player2 = player2_entry.instantiate()
var player3 = player3_entry.instantiate()
var player4 = player4_entry.instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start everybody's dancing animation
	player1.find_child("AnimationPlayer").play("RedDance")
	player2.find_child("AnimationPlayer").play("GreenDance")
	player3.find_child("AnimationPlayer").play("BlueDance")
	player4.find_child("AnimationPlayer").play("GrayDance")
	
	# Bind to everyone's buttons
	player1.find_child("Left_Button").pressed.connect(on_player1_character_backwards)
	player1.find_child("Right_Button").pressed.connect(on_player1_character_forward)
	
	find_child("Players_Container").add_child(player1)
	find_child("Players_Container").add_child(player2)
	find_child("Players_Container").add_child(player3)
	find_child("Players_Container").add_child(player4)


func on_player1_character_forward():
	var curr_player = p1_index % players.size()
	
	print("[Player 1] Next character (%d -> %d)" % [p1_index, p1_index + 1])
	
	# Remove previous sprite
	print("Previous color: %s" % players[curr_player])
	print(player1.find_child(players[curr_player] + "Player"))#.queue_free()
	
	p1_index += 1
	curr_player = p1_index % players.size()
	var pcolor = players[curr_player]
	
	print("New color: %s" % pcolor)
	
	# Switch the avatar
	var new_avi = player_models[curr_player].instantiate()
	new_avi.position.y = 450
	
	# Add it back
	player1.add_child(new_avi)
	
	# Restart its animation
	#player1.find_child(pcolor + "Player").find_child("AnimationPlayer").play(pcolor + "Dance")
	

func on_player1_character_backwards():
	print("[Player 1] Previous character")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
