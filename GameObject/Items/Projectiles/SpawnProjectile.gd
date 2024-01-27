extends Node

@export var projectile_path:String = "res://GameObject/Items/Projectile_Template.tscn"

@export var max_projectiles:int = 10
@export var frequency:int = 100
@export var frequency_variation:int = 50

@export var initial_speed:Vector2 = Vector2(0, 0)
@export var size:Vector2 = Vector2(1, 1)
@export var life_time = 100

@export var horizontal_variation:float = 0

var timer:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer == 0):
		if (get_child_count() < max_projectiles):
			pass
			#var projectile = load(projectile_path).instantiate()
			#projectile.position.x = get_parent().position.x + randf_range(-horizontal_variation, horizontal_variation)
			#projectile.position.y = get_parent().position.y
			#projectile.find_child("ProjectileShooting").speed = initial_speed
			#projectile.find_child("ProjectileShooting").life_time = life_time
			#add_child(projectile)
		timer = frequency + randf_range(-frequency_variation, frequency_variation)
	timer -= 1
	pass
