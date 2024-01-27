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
	pass
	
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

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
