extends CharacterBody3D

@onready var animatedSprite = $AnimatedSprite3D
@onready var cameraPivot = $CameraPivot
var mouseDirection: Vector2
	
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const cameraSpeed = .01

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		mouseDirection = event.screen_velocity

func _process(_delta):
	animatedSprite.play("IDLE")
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
	var input_dir := Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
