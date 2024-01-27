extends Node

const explosion = preload("res://GameObject/Items/Hazards/Explotion/Explotion.tscn")

var parent:Area2D
var gravity:float = 1
var life_time:int = 0
@export var speed:Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass

func _physics_process(_delta):
	speed.y += gravity
	parent.position += speed
	speed.x += 1 * sign(speed.x)
	parent.rotation = speed.angle()
	if (life_time < 0): parent.queue_free()
	life_time -= 1

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Terrain")):
		var explosion_instance = explosion.instantiate()
		get_tree().current_scene.add_child(explosion_instance)
		explosion_instance.position = parent.position
		print(explosion_instance.get_parent())
		explosion_instance.find_child("ExplosionSound").play()
		parent.queue_free()
