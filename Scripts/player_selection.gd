extends Node2D

# Player Entries
const player1_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player1_Entry.tscn")
const player2_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player2_Entry.tscn")
const player3_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player3_Entry.tscn")
const player4_entry = preload("res://Scenes/PlayerSelect/PlayerEntries/Player4_Entry.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate an entry for all players
	var player1 = player1_entry.instantiate()
	var player2 = player2_entry.instantiate()
	var player3 = player3_entry.instantiate()
	var player4 = player4_entry.instantiate()

	# Start everybody's dancing animation
	player1.find_child("AnimationPlayer").play("RedDance")
	player2.find_child("AnimationPlayer").play("BlueDance")
	player3.find_child("AnimationPlayer").play("GreenDance")
	player4.find_child("AnimationPlayer").play("GrayDance")
	
	find_child("Players_Container").add_child(player1)
	find_child("Players_Container").add_child(player2)
	find_child("Players_Container").add_child(player3)
	find_child("Players_Container").add_child(player4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
