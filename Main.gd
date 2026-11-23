extends Node3D

var scene
var instance

# A main script that loads the proper scenes and adds them
# as it's children. At the moment it just loads the 4 main
# scenes with no other options available. But it could
# be easily changed otherwise with If statements and flags

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Player Character
	scene = load("res://Character.tscn")
	instance = scene.instantiate()
	add_child(instance)
	
	# World Terrain
	scene = load("res://Terrain.tscn")
	instance = scene.instantiate()
	add_child(instance)

	# NPCs
	scene = load("res://NPCs.tscn")
	instance = scene.instantiate()
	add_child(instance)
	
	# World Items (Ground items, etc)
	scene = load("res://World_items.tscn")
	instance = scene.instantiate()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
