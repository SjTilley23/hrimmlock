class_name Item extends Resource

# This is a Resource class for item objects
# It allows easy addition of any usable item to the game

@export var itemName: String
@export var itemDescription: String
@export var itemDamage: int
@export var itemSpeed: int
@export var itemSprite: String
@export var useAnimation: String

func _init(itemName, itemDescription, itemDamage, itemSpeed, itemSprite, useAnimation) -> void:
	self.itemName = itemName
	self.itemDescription = itemDescription
	self.itemDamage = itemDamage
	self.itemSpeed = itemSpeed
	self.itemSprite = itemSprite
	self.useAnimation = useAnimation
