extends Node

@export var acceleration:Vector2 = Vector2(0, 0)
@export var initial_speed:Vector2 = Vector2(0, 0)
@export var gravity:float = 1

var speed:Vector2 = Vector2(5, -20)

var parent:Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass

func _physics_process(delta):
	speed.y += gravity
	parent.position += speed
	parent.rotation = lerp_angle(parent.rotation, speed.angle() + 90, 0.1)
	pass

func _on_projectile_template_body_entered(body):
	# Cuando choque contra otro body la variable body sera ese body
	pass
