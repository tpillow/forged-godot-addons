extends Node2D

export var numIslandsToGenerate: int = 10
export var islandRadiusRange := Vector2(50, 150)
export var islandXRange := Vector2(-300, 300)
export var islandYRange := Vector2(-150, 150)

onready var fLandController: FLandController = $FLandController

func _ready():
	_generateExampleLand()
	
func _process(delta):
	if Input.is_action_just_pressed("action_1"):
		_generateExampleLand()
	
func _generateExampleLand():
	fLandController.freezeUpdates = true
	fLandController.reset()
	for i in range(numIslandsToGenerate):
		var landPart := FSimpleLandCircle.new()
		landPart.setup(FUtils.randVec2(islandXRange, islandYRange),
			FUtils.randfFromVec2(islandRadiusRange))
		fLandController.addLandPart(landPart)
	fLandController.freezeUpdates = false
