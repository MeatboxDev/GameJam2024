extends Node2D

@export var camera: Camera2D

func PanoramicAnimation():
	# DEBUG
	print("[MapAnimations.gd] PanoramicAnimation(): Starting panoramic animation")
	
	# Normal values
	var normal_zoom = camera.zoom
	var normal_offset = camera.offset
	
	var zoom = 1.5
	
	await FadeIn(1.5)
	await FadeOut(0.5)
	
	# Initial camera setting
	set_zoom(zoom)
	
	FadeIn(1.0)
	
	# Pan down-up
	for i in range(150, 50, -1):
		set_offset(normal_offset.x, i)
		await wait(0.01)
		
	FadeOut(0.3)
		
	for i in range(50, 0, -1):
		set_offset(normal_offset.x, i)
		await wait(0.01)

	FadeIn(0.8)
		
	# Pan left-right
	for i in range(-300, 0, 3):
		set_offset(i, normal_offset.y)
		await wait(0.01)
		
	FadeOut(1.0)
	
	for i in range(0, 300, 3):
		set_offset(i, normal_offset.y)
		await wait(0.01)
		
	
	# Restore normal values
	camera.zoom = normal_zoom
	camera.offset = normal_offset
	

func PlayerSpawnAnimation(player: CharacterBody2D, coords: Vector2):
	# Remember normal values
	var normal_zoom = camera.zoom
	var normal_offset = camera.offset
	
	var zoom = 1.0
	var offset = normal_offset
	
	# Zoom in on spawn area
	zoom_to_position(coords.x - camera.position.x, coords.y, 2.0)
	await wait(1)
		
	# Apply changes
	#set_zoom(zoom)
	#set_offset(offset.x, offset.y)
	#await wait(0.01)

	# Spawn our buddy
	player.position = coords
	add_child(player)
	
	await wait(1.0)
		
	# Restore normal values
	camera.zoom = normal_zoom
	camera.offset = normal_offset
	
	
func SpawnPlayers(players, spawn_points):
	var used_indexes = []

	for i in players:
		while true:
			var spawn_point = spawn_points[randi() % spawn_points.size()]
			if spawn_point not in used_indexes:
				i.position.x = spawn_point.x
				i.position.y = spawn_point.y + 100
				add_child(i)
				used_indexes.append(spawn_point)
				break
	
	
func RoundStartAnimation():
	pass
	

func FadeIn(duration: float):
	# Spawn temporary black screen
	var rect = ColorRect.new()
	rect.z_index = 69
	rect.color = Color(0, 0, 0, 1)
	rect.size = Vector2(1920, 1080)
	add_child(rect)
	
	# Make it clearer overtime
	var i = 0
	while i <= 1.0:
		rect.color = Color(0, 0, 0, 1.0 - i)
		await wait((1.0 / duration) * 0.01)
		i += (1.0 / duration) * 0.01
		
	# Remove the child
	rect.queue_free()
	

func FadeOut(duration: float):
	# Spawn temporary black screen
	var rect = ColorRect.new()
	rect.color = Color(0, 0, 0, 0)
	rect.size = Vector2(1920, 1080)
	add_child(rect)
	
	# Make it clearer overtime
	var i = 0
	while i <= 1.0:
		rect.color = Color(0, 0, 0, i)
		await wait((1.0 / duration) * 0.01)
		i += (1.0 / duration) * 0.01
		
	# Remove the child
	rect.queue_free()
	

func set_zoom(zoom: float):
	camera.zoom = Vector2(zoom, zoom)

func set_offset(x: float, y: float):
	camera.offset = Vector2(x, y)

func zoom_to_position(target_x, target_y, zoom_level):
	set_zoom(zoom_level)
	camera.offset = Vector2(target_x, target_y) - (camera.get_viewport().size * 0.5 * camera.zoom)

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
