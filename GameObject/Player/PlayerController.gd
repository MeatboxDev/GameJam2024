extends Node

@export var top_speed: float = 6
@export var top_falling_speed: float = 15
@export var horizontal_acceleration: float = 60
@export var horizontal_decceleration: float = 75
@export var jump_force: float = -500
@export var gravity:float  = 75

var h_speed: float = 0
var v_speed: float = 0

var area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_parent().find_child("Area2D")
	pass # Replace with function body.a

func move():
	get_parent().position.x += h_speed
	get_parent().position.y += v_speed
	var areas = area.get_overlapping_areas().filter(func(x): return x.is_in_group("Terrain"))
	for i in areas:
		get_parent().position.y -= v_speed
		

func _physics_process(delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
	# If no direction is pressed we deccelerate
	if (horizontal_direction == 0):
		var sign = sign(h_speed)
		h_speed = sign(h_speed) * (abs(h_speed) - horizontal_decceleration * delta)
		# This buttcrack's a hack, just checks if sign of speed changed, and if it did, stop
		if (sign(h_speed) != sign): h_speed = 0
	else:
		h_speed = clamp(
			h_speed + (horizontal_direction * horizontal_acceleration * delta),
			-top_speed, top_speed)
			
	v_speed = min(v_speed + (gravity * delta), top_falling_speed)
	move()


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
