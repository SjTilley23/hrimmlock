extends CharacterBody3D

# Object creation
@onready var animatedSprite = $AnimatedSprite3D
@onready var animationPlayer = $AnimationPlayer

# Global Variables
var health = 3
var hurt = false

# Changes the health of the NPC
func TakeDamage(damage):
	health -= damage
	hurt = true
	print(health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Plays the "hurt" animation 
func PlayHurtAni():
	animationPlayer.play("hurt")
	hurt = false
	await animationPlayer.animation_finished

# Changes the animation to the "corpse" animation
func PlayCorpse():
	animationPlayer.play("corpse")
	await animationPlayer.animation_finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# if health falls to or below 0, play "corpse" animation
	if (health <= 0):
		PlayCorpse()
	
	# Otherwise if just hurt, play the "hurt" animation
	elif (hurt and animationPlayer.current_animation != "hurt"):
		PlayHurtAni()
	
	# Otherwise, play the "idle" animation
	else:
		animationPlayer.play("idle")
	
	
