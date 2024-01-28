extends Node

var player_owner:CharacterBody2D = null
var used:bool = false

var use_time:int = 270
var timer: int = use_time

var h_speed:float
var v_speed:float

var shovel:Node2D

func _ready():
	shovel = get_parent()
	h_speed = 0
	v_speed = 0
	pass
	
func _physics_process(_delta):
	if player_owner == null and not used: return
	if timer < 0 and not used:
		# Specify "dispose" speed
		h_speed = -sign(player_owner.direction) * randf_range(0, 25)
		v_speed = randf_range(-10, -30)
		
		# Specify this weapon as used and remove weapon from owner
		used = true
		player_owner.find_child("HoldingScript").weapon = null
		player_owner = null
	timer -= 1
	
	if timer < 0:
		v_speed += 1
		shovel.position += Vector2(h_speed, v_speed)
		shovel.rotation += PI/60
		if shovel.position.y > 1500: shovel.queue_free()

func Activate(_direction):
	# Don't delete this function, shit breaks if you do
	pass

func _on_area_2d_body_entered(body):
	if (body.is_in_group("Terrain") or body.is_in_group("Platform")) and not used:
		player_owner.velocity.y = player_owner.JUMP_VELOCITY * player_owner.SPEED
		player_owner.jumps = 0

func _on_area_2d_area_entered(area):
	if player_owner == null or player_owner == area.get_parent(): return
	if area.is_in_group("Player"):
		print("Player Collision")
		area.get_parent().Die()
		player_owner.velocity.y = player_owner.JUMP_VELOCITY * player_owner.SPEED
		player_owner.jumps = 0
		return
