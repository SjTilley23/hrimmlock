extends Area3D

@onready var swordSprite = preload("res://SpriteSheets/Sword02000.png")
@onready var containedItem = Item.new("Sword", 
	"A Sword", 
	2, 
	1.2, 
	swordSprite, 
	"Sword02Swing")


func Interact():
	return "PickupItem"

func PickupItem():
	return containedItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite3D.texture = containedItem.itemSprite
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
