extends Node

const rocket = preload("res://GameObject/Items/Projectiles/Rocket.tscn")

func Activate(direction):
	var rocket_instance = rocket.instantiate()
	get_parent().get_parent().add_child(rocket_instance)
	rocket_instance.position = get_parent().position
	rocket_instance.find_child("Script").speed = Vector2(direction * 30, -5)
	rocket_instance.find_child("Script").life_time = 900
	print("TEST")
	pass
