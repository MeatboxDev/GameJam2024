extends Node

var player_owner:CharacterBody2D = null
var used:bool = false
const rocket = preload("res://GameObject/Items/Projectiles/Bomb Projectile/Bomb.tscn")

var h_speed:float
var v_speed:float

var bomb_root:Node2D
var bomb_sprite:Area2D

func _ready():
	bomb_root = get_parent()
	bomb_sprite = bomb_root.find_child("Area2D")

func Activate(direction):
	# When player uses rocket launcher instantiate rocket
	var projectile_instance = rocket.instantiate()
	
	# Add rocket as child of root
	get_tree().current_scene.add_child(projectile_instance)
	
	# Specify rocket properties
	projectile_instance.position = get_parent().position
	projectile_instance.find_child("Script").speed = Vector2(direction * 15, -15)
	projectile_instance.find_child("Script").speed
	projectile_instance.find_child("Script").life_time = 900
	
	# Specify this weapon as used and remove weapon from owner
	used = true
	player_owner.find_child("HoldingScript").weapon = null
	player_owner = null
	
	# Ditch Bomb Weapon
	bomb_root.queue_free()
	pass
