extends Node

const rocket = preload("res://GameObject/Items/Projectiles/Rocket.tscn")

func Activate((float)direction):
	var rocket_instance = rocket.instantiate()
	get_parent().add_child(rocket_instance)
	rocket_instance.find_child("Script").speed = Vector2(direction * 100, -5)
	print("TEST")
	pass
