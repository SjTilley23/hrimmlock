extends Node3D

var equipment = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var item = Item.new("Sword", 
	"A Sword", 
	1, 
	1, 
	"Sword01", 
	"Sword01Swing")
	
	equipment.append(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
