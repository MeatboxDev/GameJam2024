extends Node

var gravity:float = 1
var life_time:int = 0
@export var speed:Vector2 = Vector2(0, 0)

var parent:Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass

func _physics_process(delta):
	speed.y += gravity
	parent.position += speed
	parent.rotation = speed.angle()
	if (life_time < 0): parent.queue_free()
	life_time -= 1

func _on_projectile_template_body_entered(body):
	# Cuando choque contra otro body la variable body sera ese body
	pass
