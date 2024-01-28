extends Node

var player_owner:CharacterBody2D = null
var used:bool = false
const bone = preload("res://GameObject/Items/Projectiles/Bone Projectile/BoneProjectile.tscn")

var h_speed:float
var v_speed:float

var bone_root:Node2D
var bone_sprite:Area2D

func _ready():
	bone_root = get_parent()
	bone_sprite = bone_root.find_child("Area2D")

func Activate(direction):
	# When player uses rocket launcher instantiate rocket
	var projectile = bone.instantiate()
	
	# Add projectile as child of root
	get_tree().current_scene.add_child(projectile)
	
	# Specify rocket properties
	projectile.position = get_parent().position
	projectile.find_child("Script").speed = Vector2(direction * 15, 0)
	projectile.find_child("Script").life_time = 900
	projectile.find_child("Script").responsible = player_owner.find_child("Collision Box")
	
	# Specify this weapon as used and remove weapon from owner
	used = true
	player_owner.find_child("HoldingScript").weapon = null
	player_owner = null
	
	# Delete Bone ("We're Throwing it")
	bone_root.queue_free()
	pass
