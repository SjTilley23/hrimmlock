#extends Node3D
#
#@onready var camera3D  = $Camera3D
#var mouseDirection: Vector2
#const cameraSpeed = .01
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#func _input(event):
	#if event is InputEventMouseMotion:
		#mouseDirection = event.screen_velocity
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta) -> void:
	#rotate_x(mouseDirection.y * cameraSpeed * _delta)
