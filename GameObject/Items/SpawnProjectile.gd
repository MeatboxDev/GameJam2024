extends Node

@export var projectile_path:String = "res://GameObject/Items/Projectile_Template.tscn"
@export var max_projectiles:int = 10
@export var frequency:int = 100
@export var size:Vector2 = Vector2(1, 1)

var timer:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer == 0):
		if (get_child_count() < max_projectiles):
			var projectile = load(projectile_path).instantiate()
			projectile.position = get_parent().position
			projectile.find_child("ProjectileShooting").speed = Vector2(-10, -50)
			add_child(projectile)
		
		timer = frequency
	timer -= 1
	pass
