extends Node3D

# Global Variables
var hotbar = []
var currentSelection = 0

# Attacks the enemy by casting a ray, determining if that ray
# intersects with an enemy. if so it accesses the enemy's 
# takeDamage function and uses it.
func Attack(damage):
	
	# Local Variables
	var character = get_parent()
	var origin = character.position
	var direction = -character.global_transform.basis.z
	var distance = 3
	var end = origin + direction * distance
	var intersect = PhysicsRayQueryParameters3D.create(origin, end)
	
	# Excludes our character from the raycast intersection check
	intersect.exclude = [character]
	
	# Determines if our ray actually intersects something
	var result = get_world_3d().direct_space_state.intersect_ray(intersect)
	
	if result:
		# Gets the collider of the intersected object
		var target = result.collider
		
		# if its an enemy, make them take damage
		if target.has_method("TakeDamage"):
			target.TakeDamage(damage)
		# Otherwise, do nothing
		else:
			pass

# Changes our hotbar selection
func hotbarSelection(numSelect):
	currentSelection = numSelect
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Gives our hotbar a set size and fills it with null
	hotbar.resize(9)
	hotbar.fill(null)
	
	# Two Example items temporarily created here for testing
	var item = Item.new("Sword", 
	"A Sword", 
	1, 
	1, 
	"Sword01", 
	"Sword01Swing")
	
	var item2 = Item.new("Sword2",
	"Another sword",
	2,
	1.2,
	"Sword02",
	"Sword02Swing")
	
	# Adds the items to our hotbar
	hotbar.set(0, item)
	hotbar.set(1, item2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
