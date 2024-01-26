extends CharacterBody2D

var jumping = false

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@export var JUMP_ACCELERATION = 100.0
@export var DEACCEL_FACTOR = 0.9

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		jumping = true
	elif Input.is_action_just_released("jump"):
		jumping = false
		
	if jumping:
		if velocity.y >= JUMP_VELOCITY:
			velocity.y -= JUMP_ACCELERATION
		else:
			jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		
		# Face the direction you're walking towards
		scale.x = scale.y * direction

	else:
		velocity.x *= DEACCEL_FACTOR

	move_and_slide()
	
