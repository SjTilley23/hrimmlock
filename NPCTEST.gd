extends CharacterBody3D
@onready var animatedSprite = $AnimatedSprite3D

var health = 3

func TakeDamage(damage):
	health -= damage
	print(health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play("IdleNPCTEST")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
