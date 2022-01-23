extends Node2D

const PL_SIMPLE_TREE := preload("res://example_scenes/simple_tree/SimpleTree.tscn")

export var numIslandsToGenerate: int = 10
export var islandRadiusRange := Vector2(50, 150)
export var islandXRange := Vector2(-300, 300)
export var islandYRange := Vector2(-150, 150)
export var camRotationSpeedDegs: float = 30.0
export var numTreesToGenerate: int = 100

onready var fLandController: FLandController = $FLandController
onready var cam: Camera2D = $Cam
onready var fPerspYSort: FPerspYSort = $FPerspYSort

func _ready():
	_generateExampleLand()
	
func _process(delta):
	if Input.is_action_just_pressed("action_1"):
		_generateExampleLand()

	if Input.is_action_pressed("rotate_left"):
		cam.rotation_degrees += camRotationSpeedDegs * delta
	elif Input.is_action_pressed("rotate_right"):
		cam.rotation_degrees += -camRotationSpeedDegs * delta
	
func _generateExampleLand():
	fLandController.freezeUpdates = true # Just prevents unnecessary updates while building
	fLandController.reset()
	for child in fPerspYSort.get_children():
		child.queue_free()

	for i in range(numIslandsToGenerate):
		# Create the land part
		var landPart := FSimpleLandCircle.new()
		var landPos := FUtils.randVec2(islandXRange, islandYRange)
		landPart.setup(landPos,
			FUtils.randfFromVec2(islandRadiusRange))
		fLandController.addLandPart(landPart)
		
	_generateTrees()

	fLandController.freezeUpdates = false

func _generateTrees():
	var simpleTree := PL_SIMPLE_TREE.instance()
	simpleTree.position = Vector2(0, -10)
	fPerspYSort.add_child(simpleTree)

	simpleTree = PL_SIMPLE_TREE.instance()
	simpleTree.position = Vector2(-10, 0)
	fPerspYSort.add_child(simpleTree)

	simpleTree = PL_SIMPLE_TREE.instance()
	simpleTree.position = Vector2(10, 10)
	fPerspYSort.add_child(simpleTree)

#	for i in range(numTreesToGenerate):
#		var treePos := FUtils.randVec2(islandXRange, islandYRange)
#		while not fLandController.isPointOnLand(treePos):
#			treePos = FUtils.randVec2(islandXRange, islandYRange)
#			# TODO: should probably have a safety to prevent infinite loop
#		var simpleTree := PL_SIMPLE_TREE.instance()
#		simpleTree.position = treePos
#		fPerspYSort.add_child(simpleTree)
