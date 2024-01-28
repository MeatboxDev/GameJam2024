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
	var projectile = rocket.instantiate()
	
	# Add rocket as child of root
	get_tree().current_scene.add_child(projectile)
	
	# Specify rocket properties
	projectile.position = get_parent().position
	projectile.find_child("Script").speed = Vector2(direction * 15, -15)
	projectile.find_child("Script").speed
	projectile.find_child("Script").life_time = 900
	projectile.find_child("Script").responsible = player_owner.find_child("Collision Box")
	
	# Specify this weapon as used and remove weapon from owner
	used = true
	player_owner.find_child("HoldingScript").weapon = null
	player_owner = null
	
	# Ditch Bomb Weapon
	bomb_root.queue_free()
	pass
