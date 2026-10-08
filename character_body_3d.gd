extends CharacterBody3D

@onready var cameraPivot = $CameraPivot
var mouseDirection: Vector2
	
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const cameraSpeed = .4
var mvVec = Vector3(0,0,0)
var sinCP
var cosCP

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		mouseDirection = event.relative

func _process(_delta):
	rotate_y(-mouseDirection.x * cameraSpeed * _delta)
	cameraPivot.rotation.y = rotation.y
	cameraPivot.rotation.x += -mouseDirection.y * cameraSpeed * _delta
	
	mouseDirection.x = 0
	mouseDirection.y = 0
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	# Get the input direction and handle the movement/deceleration.
	sinCP = sin(cameraPivot.rotation.y)
	cosCP = cos(cameraPivot.rotation.y)
	
	if Input.is_action_pressed("moveForward"):
		mvVec += Vector3(-sinCP,0,-cosCP)
	elif Input.is_action_pressed("moveBack"):
		mvVec += Vector3(sinCP,0,cosCP)
	if Input.is_action_pressed("moveLeft"):
		mvVec += Vector3(-cosCP, 0, sinCP)
	if Input.is_action_pressed("moveRight"):
		mvVec += Vector3(cosCP, 0, -sinCP)
		
		
	var direction := (transform.basis * mvVec).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	mvVec = Vector3(0,0,0)

	move_and_slide()
