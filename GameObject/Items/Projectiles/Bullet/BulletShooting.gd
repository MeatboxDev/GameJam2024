extends Node

var parent:Area2D
var gravity:float = 0
var life_time:int = 0
var speed:Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass

func _physics_process(_delta):
	speed.y += gravity
	parent.position += speed 
	parent.rotation = speed.angle()
	if (life_time < 0): parent.queue_free()
	life_time -= 1

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Terrain")):
		parent.queue_free()
