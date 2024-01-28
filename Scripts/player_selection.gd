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

const player_colors = ["Red", "Green", "Blue", "Gray"]
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
var players = [player1, player2, player3, player4]

# Controller stuff
var player_slots = [true, true, true, true]
var connected_controllers = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	# Bind to controller stuff
	Input.joy_connection_changed.connect(on_joycon_connection_changed)
	
	# Start everybody's dancing animation
	player1.find_child("AnimationPlayer").play("RedDance")
	player2.find_child("AnimationPlayer").play("GreenDance")
	player3.find_child("AnimationPlayer").play("BlueDance")
	player4.find_child("AnimationPlayer").play("GrayDance")
	
	# Bind to everyone's buttons
	player1.find_child("Left_Button").pressed.connect(on_player1_character_backwards)
	player1.find_child("Right_Button").pressed.connect(on_player1_character_forward)
	player2.find_child("Left_Button").pressed.connect(on_player2_character_backwards)
	player2.find_child("Right_Button").pressed.connect(on_player2_character_forward)
	player3.find_child("Left_Button").pressed.connect(on_player3_character_backwards)
	player3.find_child("Right_Button").pressed.connect(on_player3_character_forward)
	player4.find_child("Left_Button").pressed.connect(on_player4_character_backwards)
	player4.find_child("Right_Button").pressed.connect(on_player4_character_forward)
	
	#find_child("Players_Container").add_child(player1)
	#find_child("Players_Container").add_child(player2)
	#find_child("Players_Container").add_child(player3)
	#find_child("Players_Container").add_child(player4)


func on_joycon_connection_changed(device: int, connected: bool):
	var device_name = Input.get_joy_name(device)
	var device_guid = Input.get_joy_guid(device)
	
	print("Device %d: %s (%s). %s" % [device, device_name, device_guid, "Connected" if connected else "Disconnected"])
	
	# Let's make sure there are available player slots
	if true not in player_slots:
		return
	
	# A controller has just been connected
	if connected:
		# First we check if it's unique or if it already exists
		for i in connected_controllers.keys():
			if connected_controllers[i]["guid"] == device_guid:
				# The device is a duplicate. Ignore it
				return
		
		# The device is new. Let's assign it a slot
		var slot = FindAvailablePlayerSlot()
		
		# Now let's add it
		connected_controllers[device] = {
			"name": Input.get_joy_name(device),
			"guid": Input.get_joy_guid(device),
			"slot": slot,
		}
		
		# Finally, let's add an entry for it
		find_child("Players_Container").add_child(players[slot])
		
	# A controller has just been disconnected
	else:
		print(connected_controllers)
		# Let's avoid trying to remove duplicate controllers we're ignoring
		if device in connected_controllers.keys():
			# Remove the player entry
			find_child("Players_Container").remove_child(players[connected_controllers[device]["slot"]])
			
			# Free the slot
			FreePlayerSlot(connected_controllers[device]["slot"])
			connected_controllers.erase(device)


func FindAvailablePlayerSlot():
	var i = 0
	while i < player_slots.size():
		if player_slots[i] == true:
			player_slots[i] = false
			return i
		i += 1
	

func FreePlayerSlot(id: int):
	player_slots[id] = true


# If one slot were to be freed, rotate the lobby


func ReplaceAvatar(target, previous, newone):
	# Remove previous sprite
	target.get_node(previous).queue_free()
	
	# Add the new one
	target.add_child(newone)


func ForwardAvatar(target, index):
	var indx = index % player_colors.size()
	var new_indx = (index+1) % player_colors.size()
	
	var prev_color = player_colors[indx]
	var new_color = player_colors[new_indx]
	var prev_avi_name = prev_color + "Player"
	var new_avi_name = new_color + "Player"
	
	# Switch the avatar
	var new_avi = player_models[new_indx].instantiate()
	new_avi.position.y = 450
	
	# Restart its animation
	new_avi.get_node("AnimationPlayer").play(new_color + "Dance")

	# Perform the replacement
	ReplaceAvatar(target, prev_avi_name, new_avi)
	
	
func BackwardsAvatar(target, index):
	var indx = index % player_colors.size()
	var new_indx = (index-1) % player_colors.size()
	
	var prev_color = player_colors[indx]
	var new_color = player_colors[new_indx]
	var prev_avi_name = prev_color + "Player"
	var new_avi_name = new_color + "Player"
	
	# Switch the avatar
	var new_avi = player_models[new_indx].instantiate()
	new_avi.position.y = 450
	
	# Restart its animation
	new_avi.get_node("AnimationPlayer").play(new_color + "Dance")

	# Perform the replacement
	ReplaceAvatar(target, prev_avi_name, new_avi)


func on_player1_character_forward():
	ForwardAvatar(player1, p1_index)
	p1_index += 1


func on_player1_character_backwards():
	BackwardsAvatar(player1, p1_index)
	p1_index -= 1


func on_player2_character_forward():
	ForwardAvatar(player2, p2_index)
	p2_index += 1


func on_player2_character_backwards():
	BackwardsAvatar(player2, p2_index)
	p2_index -= 1


func on_player3_character_forward():
	ForwardAvatar(player3, p3_index)
	p3_index += 1
	
	
func on_player3_character_backwards():
	BackwardsAvatar(player3, p3_index)
	p3_index -= 1


func on_player4_character_forward():
	ForwardAvatar(player4, p4_index)
	p4_index += 1


func on_player4_character_backwards():
	BackwardsAvatar(player4, p4_index)
	p4_index -= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
