extends Node3D

var hotbar = []
var currentSelection = 0

func Attack(damage):
	var character = get_parent()
	var origin = character.position
	var direction = -character.global_transform.basis.z
	var distance = 3
	var end = origin + direction * distance
	
	var intersect = PhysicsRayQueryParameters3D.create(origin, end)
	intersect.exclude = [character]
	var result = get_world_3d().direct_space_state.intersect_ray(intersect)
	
	if result:
		var target = result.collider
		if target.has_method("TakeDamage"):
			target.TakeDamage(damage)
		else:
			pass

func hotbarSelection(numSelect):
	currentSelection = numSelect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hotbar.resize(9)
	hotbar.fill(null)
	
	
	var item = Item.new("Sword", 
	"A Sword", 
	1, 
	1, 
	"Sword01", 
	"Sword01Swing")
	
	hotbar.set(0, item)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
