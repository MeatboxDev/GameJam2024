extends Node

var player_owner:CharacterBody2D = null
var used:bool = false
const rocket = preload("res://GameObject/Items/Projectiles/Bullet/Bullet.tscn")

var h_speed:float
var v_speed:float

var gun_root:Node2D
var gun_sprite:Area2D

var uses:int = 2

func _ready():
	gun_root = get_parent()
	gun_sprite = gun_root.find_child("Area2D")

func _physics_process(delta):
	if used:
		gun_root.position += Vector2(h_speed, v_speed)
		gun_sprite.rotation += PI/60
		v_speed += 1
		if gun_root.position.y > 1500: gun_root.queue_free()

func Activate(direction):
	# When player uses rocket launcher instantiate rocket
	var projectile = rocket.instantiate()
	
	# Add rocket as child of root
	get_tree().current_scene.add_child(projectile)
	
	# Specify rocket properties
	projectile.position = get_parent().position
	projectile.find_child("Script").speed = Vector2(direction * 25, 0)
	projectile.find_child("Script").gravity = 0
	projectile.find_child("Script").life_time = 900
	projectile.find_child("Script").responsible = player_owner.find_child("Collision Box")
	
	uses -= 1
	
	# Specify this weapon as used and remove weapon from owner
	if uses == 0:
		used = true
		player_owner.find_child("HoldingScript").weapon = null
		player_owner = null
	
		# Specify "dispose" speed
		h_speed = -sign(direction) * randf_range(0, 25)
		v_speed = randf_range(-10, -30)
	pass
