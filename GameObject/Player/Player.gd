extends CharacterBody2D

var alive: bool = true
var jumps = 0
var joy_button_pressed = false

@export var player_index = 0

@export var SPEED = 500.0
@export var JUMP_VELOCITY = -2.0
@export var DEACCEL_FACTOR = 0.9
@export var GRAVITY = 3 * 1000

var direction

# Joycon keys
const JOYCON_LEFT = 14
const JOYCON_RIGHT = 15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _input(event):
	if event is InputEventJoypadButton and event.is_pressed():
		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A) and event.button_index == JOY_BUTTON_A and not joy_button_pressed:
			# Player pressed X
			joy_button_pressed = true
			jumps += 1
	
	elif event is InputEventJoypadButton and event.is_released():
		if not Input.is_joy_button_pressed(player_index, JOY_BUTTON_A) and event.button_index == JOY_BUTTON_A:
			# Player released X
			joy_button_pressed = false
			

func _physics_process(delta):
	if not alive: return
	if not direction and is_on_floor():
		anim.play("RESET")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			anim.play("Fall")
	else:
		# Reset double jump
		jumps = 0
	
	# Handle jumping and double jumping
	#if Input.is_action_just_pressed("jump"):
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A):
		anim.play("Jump")
		if jumps < 2 and joy_button_pressed:
			joy_button_pressed = false
			velocity.y = JUMP_VELOCITY * SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("move_left", "move_right")
	direction = round(Input.get_joy_axis(player_index, JOY_AXIS_LEFT_X))
	if direction:
		if is_on_floor():
			anim.play("Run")
		velocity.x = direction * SPEED
		
		# Face the direction you're walking towards
		scale.x = scale.y * direction

	else:
		velocity.x *= DEACCEL_FACTOR
	move_and_slide()

func Die():
	alive = false
	hide()
