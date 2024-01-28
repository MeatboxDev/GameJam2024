extends Node

var responsible:Area2D
var parent:Area2D
var gravity:float = 0
var life_time:int = 0
var speed:Vector2 = Vector2(0, 0)

var opposite_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass

func _physics_process(_delta):
	speed.y += gravity
	speed.x += opposite_direction
	parent.position += speed
	parent.rotation += PI/24
	if (life_time < 0): parent.queue_free()
	life_time -= 1

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Terrain")):
		parent.queue_free()

func _on_area_2d_area_entered(area):
	if area == responsible: return
	if area.is_in_group("Player"):
		print("Player Collision")
		area.get_parent().Die()
		parent.queue_free()
		return
