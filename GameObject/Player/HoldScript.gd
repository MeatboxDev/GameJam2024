extends Node

var weapon:Node2D = null
var player:CharacterBody2D = null
var hold_area:Area2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	hold_area = player.find_child("Hold")
	pass
	
func hold() -> Node2D:
	if (weapon != null): return weapon
	for i in hold_area.get_overlapping_areas():
		if i.is_in_group("Holdable"):
			if i.get_parent().find_child("Activate").used == false:
				return i.get_parent()
	return null

func _process(_delta):
	if (weapon != null):
		match weapon.name:
			"Shovel":
				weapon.position.x = player.position.x
				weapon.position.y = player.position.y + 50
			_:
				weapon.position = player.position
			
		weapon.scale.x = abs(weapon.scale.x) * sign(player.scale.y)
		if Input.is_action_just_pressed("debug_action"):
			weapon.find_child("Activate").Activate(sign(player.scale.y))
	else:
		if Input.is_action_just_pressed("debug_action"):
			weapon = hold()
			if weapon != null: weapon.find_child("Activate").player_owner = get_parent()
	pass
