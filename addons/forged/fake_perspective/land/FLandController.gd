class_name FLandController
extends Node2D
const __is_FLandController: bool = true

export var _controllerGroupName: String = FPerspController.DEFAULT_PERSP_CONTROLLER_GROUP_NAME
export var queueFreeLandPartsOnRemoval: bool = true

var _landParts: Array = []
var _freezeUpdates: bool = false
var _lastFPerspController: FPerspController = null

var freezeUpdates: bool setget _setFreezeUpdates, _getFreezeUpdates
var landParts: Array setget , _getLandParts
var fPerspController: FPerspController setget , _getFPerspController

func _ready():
	Forged.GroupUtil.addNodeToGroup(self, _controllerGroupName)
	reset()

func onFPerspControllerUpdated(fPerspController: FPerspController):
	_lastFPerspController = fPerspController
	fpLandUpdate()
	
func reset():
	if queueFreeLandPartsOnRemoval:
		for part in _landParts:
			assert(part.has_method("queue_free"),
				"FLandController: if 'queueFreeLandPartsOnRemoval' is true, all land parts must have a 'queue_free()' method")
			part.queue_free()
	_landParts.clear()
	fpLandUpdate()

func fpLandUpdate():
	if _freezeUpdates:
		return
	for child in get_children():
		if child.has_method("fpLandUpdate"):
			child.fpLandUpdate()

func isPointOnLand(point: Vector2) -> bool:
	for part in _landParts:
		assert(part.has_method("containsPoint"),
			"FLandController: to use 'isPointOnLand()', all land parts must contain a 'containsPoint(Vector2)' method")
		if part.containsPoint(point):
			return true
	return false

# NOTE: changing properties of a part after adding it will NOT trigger automatic updates
# instead if properties change, a manual update must be triggered
func addLandPart(part):
	_landParts.append(part)
	fpLandUpdate()

func _getLandParts() -> Array:
	return _landParts

func _setFreezeUpdates(freeze: bool):
	_freezeUpdates = freeze
	if not _freezeUpdates:
		fpLandUpdate()
		
func _getFreezeUpdates() -> bool:
	return _freezeUpdates

func _getFPerspController() -> FPerspController:
	return _lastFPerspController # I don't really like this, but it should work
