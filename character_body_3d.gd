extends CharacterBody3D

# Getting objects of child nodes
@onready var cameraPivot = $CameraPivot
@onready var equipmentNode = get_node("Equipment")
@onready var animatedSprite2D = $AnimatedSprite2D

# Global Variables
var mouseDirection: Vector2
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const cameraSpeed = .4
var mvVec = Vector3(0,0,0)
var sinCP
var cosCP

# Use Item in Left Hand
func useLeft():
	var leftHandItem = getEquipped()

	# if holding an item, uses its animation and attack
	if (leftHandItem != null):
		animatedSprite2D.playAnimation(leftHandItem.useAnimation)
		equipmentNode.Attack(leftHandItem.itemDamage)
	
# Use Item in Right Hand
func useRight():
	pass
	
func getEquipped():
	
	# Gets the list of hotbar items
	var cEquip = equipmentNode.hotbar
	
	# Gets the currently equipped item
	var leftHandItem = cEquip[equipmentNode.currentSelection]
	return leftHandItem
	
# When Node is initialized do ...
func _ready():
	# Begin Capture of Mouse Movements
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Handles Events like mouse motion, clicking, or keyboard input
func _input(event):
	# checks for mouse motion and logs it
	if event is InputEventMouseMotion:
		mouseDirection = event.relative
	
	# Determines if either left or right hand is used
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			useLeft()
		if event.button_index == 2:
			useRight()
	
	# Checks for hotbar inputs (1, 2, 3 ... etc)
	if Input.is_action_just_pressed("hotbar 1"):
		equipmentNode.hotbarSelection(0)
		var leftHandItem = getEquipped()
		animatedSprite2D.playAnimation(leftHandItem.useAnimation)
		animatedSprite2D.stop()
		
		
	elif (Input.is_action_just_pressed("hotbar 2")):
		equipmentNode.hotbarSelection(1)
		var leftHandItem = getEquipped()
		animatedSprite2D.playAnimation(leftHandItem.useAnimation)
		animatedSprite2D.stop()

# Runs every frame
func _process(_delta):
	
	# controls camera movement
	# Rotates the characters y axis (left to right)
	rotate_y(-mouseDirection.x * cameraSpeed * _delta)
	
	# sets cameraPivots y rotation to the characters
	cameraPivot.rotation.y = rotation.y
	
	# Rotates cameraPivots x axis
	cameraPivot.rotation.x += -mouseDirection.y * cameraSpeed * _delta
	
	# Resets our mouse Direction variables
	mouseDirection.x = 0
	mouseDirection.y = 0
	
# Runs every frame
func _physics_process(delta: float) -> void:
	
	# Adds gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handles jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Determines the direction of our movement vectors based
	# on which way the camera is facing
	sinCP = sin(cameraPivot.rotation.y)
	cosCP = cos(cameraPivot.rotation.y)
	
	# Gets the input direction and creates the movement vectors
	if Input.is_action_pressed("moveForward"):
		mvVec += Vector3(-sinCP,0,-cosCP)
	elif Input.is_action_pressed("moveBack"):
		mvVec += Vector3(sinCP,0,cosCP)
	if Input.is_action_pressed("moveLeft"):
		mvVec += Vector3(-cosCP, 0, sinCP)
	if Input.is_action_pressed("moveRight"):
		mvVec += Vector3(cosCP, 0, -sinCP)
		
	# Normalizes our vectors and multiplies by speed
	# Keeps our speed consistent
	var direction := (transform.basis * mvVec).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# Resets our movement vector
	mvVec = Vector3(0,0,0)

	# Actually moves the character based on velocity
	move_and_slide()
