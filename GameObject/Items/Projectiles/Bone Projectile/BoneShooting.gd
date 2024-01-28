extends Node

var responsible:Area2D # This area will be ignored by the projectile
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
	parent.rotation += PI/12
	if (life_time < 0): parent.queue_free()
	life_time -= 1

func _on_area_2d_body_entered(body:RigidBody2D):
	if body.is_in_group("Terrain"):
		parent.queue_free()
		return
		
func _on_area_2d_area_entered(area):
	if area == responsible: return
	if area.is_in_group("Player"):
		print("Player Collision")
		area.get_parent().Die()
		parent.queue_free()
		return
