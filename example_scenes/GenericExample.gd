extends Node2D

const PL_SIMPLE_TREE := preload("res://example_scenes/simple_tree/SimpleTree.tscn")

export var numIslandsToGenerate: int = 10
export var islandRadiusRange := Vector2(50, 150)
export var islandXRange := Vector2(-300, 300)
export var islandYRange := Vector2(-150, 150)
export var camRotationSpeedDegs: float = 30.0

onready var fLandController: FLandController = $FLandController
onready var cam: Camera2D = $Cam
onready var objects: Node2D = $Objects

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
	for child in objects.get_children():
		child.queue_free()

	for i in range(numIslandsToGenerate):
		# Create the land part
		var landPart := FSimpleLandCircle.new()
		var landPos := FUtils.randVec2(islandXRange, islandYRange)
		landPart.setup(landPos,
			FUtils.randfFromVec2(islandRadiusRange))
		fLandController.addLandPart(landPart)
		
		# Slap a simple tree in the center of each
		var simpleTree := PL_SIMPLE_TREE.instance()
		simpleTree.position = landPos
		objects.add_child(simpleTree)

	fLandController.freezeUpdates = false
