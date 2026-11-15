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
	var origin = character.global_position + Vector3(0,0,.3)
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
	
func AddToHotbar(item):
	for x in range(hotbar.size()):
		if hotbar[x] == null:
			hotbar.set(x,item)
	
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
	null, 
	"Sword01Swing")
	
	# Adds the items to our hotbar
	hotbar.set(0, item)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
