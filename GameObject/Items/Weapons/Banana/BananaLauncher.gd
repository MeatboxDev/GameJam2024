extends Node

var player_owner:CharacterBody2D = null
var used:bool = false
const banana = preload("res://GameObject/Items/Projectiles/Banana Projectile/Banana Projectile.tscn")

var h_speed:float
var v_speed:float

var banana_root:Node2D
var banana_sprite:Area2D

func _ready():
	banana_root = get_parent()
	banana_sprite = banana_root.find_child("Area2D")

func Activate(direction):
	# When player uses rocket launcher instantiate rocket
	var projectile = banana.instantiate()
	
	# Add projectile as child of root
	get_tree().current_scene.add_child(projectile)
	
	# Specify rocket properties
	projectile.position = get_parent().position
	projectile.find_child("Script").speed = Vector2(direction * 30, 0)
	projectile.find_child("Script").opposite_direction = -sign(direction)
	projectile.find_child("Script").life_time = 900
	projectile.find_child("Script").responsible = player_owner.find_child("Collision Box")
	
	# Specify this weapon as used and remove weapon from owner
	used = true
	player_owner.find_child("HoldingScript").weapon = null
	player_owner = null
	
	# Delete banana ("We're Throwing it")
	banana_root.queue_free()
	pass
