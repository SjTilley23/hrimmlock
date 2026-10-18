extends CharacterBody3D
@onready var animatedSprite = $AnimatedSprite3D
@onready var animationPlayer = $AnimationPlayer

var health = 3
var hurt = false

func TakeDamage(damage):
	health -= damage
	hurt = true
	print(health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
func PlayHurtAni():
	animationPlayer.play("hurt")
	hurt = false
	await animationPlayer.animation_finished

func PlayCorpse():
	animationPlayer.play("corpse")
	await animationPlayer.animation_finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (health <= 0):
		PlayCorpse()
	elif (hurt and animationPlayer.current_animation != "hurt"):
		PlayHurtAni()
	elif (animationPlayer.current_animation != "idle" and 
			animationPlayer.current_animation != "hurt"):
		animationPlayer.play("idle")
	
	
