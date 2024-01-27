extends Node

var player_owner:CharacterBody2D = null
var used:bool = false
const rocket = preload("res://GameObject/Items/Projectiles/Rocket/Rocket.tscn")

var h_speed:float
var v_speed:float

var rocket_root:Node2D
var rocket_sprite:Area2D

func _ready():
	rocket_root = get_parent()
	rocket_sprite = rocket_root.find_child("Area2D")

func _physics_process(delta):
	if used:
		rocket_root.position += Vector2(h_speed, v_speed)
		rocket_sprite.rotation += PI/60
		v_speed += 1
		if rocket_root.position.y > 1500: rocket_root.queue_free()

func Activate(direction):
	# When player uses rocket launcher instantiate rocket
	var rocket_instance = rocket.instantiate()
	
	# Add rocket as child of root
	get_tree().current_scene.add_child(rocket_instance)
	
	# Specify rocket properties
	rocket_instance.position = get_parent().position
	rocket_instance.find_child("Script").speed = Vector2(direction * 10, 0)
	rocket_instance.find_child("Script").gravity = 0
	rocket_instance.find_child("Script").life_time = 900
	
	# Specify this weapon as used and remove weapon from owner
	used = true
	player_owner.find_child("HoldingScript").weapon = null
	player_owner = null
	
	# Specify "dispose" speed
	h_speed = -sign(direction) * randf_range(0, 25)
	v_speed = randf_range(-10, -30)
	pass
