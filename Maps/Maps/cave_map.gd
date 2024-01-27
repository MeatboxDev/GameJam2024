extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	const player_scene = preload("res://GameObject/Player/Player.tscn")
	const boykisser_scene = preload("res://GameObject/Player/Boykisser.tscn")
	
	# Controllers
	print(Input.get_connected_joypads())
	#var connected_controllers = Input.get_connected_joypads()
	
	# Player 1
	var player1 = player_scene.instantiate()
	player1.player_index = 0
	add_child(player1)
	
	# Player 2
	#var player2 = boykisser_scene.instantiate()
	#player2.player_index = 2
	#add_child(player2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
