class_name FPLandController
extends Node2D
var __is_FPLandController: bool = true

export var _groupName: String = FPController.DEFAULT_FORGED_PERSPECTIVE_GROUP
export(NodePath) var fpControllerPath: NodePath
export var queueFreeLandPartsOnRemoval: bool = true

var _landParts: Array = []
var _freezeUpdates: bool = false
var _fpController: FPController = null

var freezeUpdates: bool setget _setFreezeUpdates, _getFreezeUpdates
var landParts: Array setget , _getLandParts
var fpController: FPController setget , _getFpController

func _enter_tree():
	add_to_group(_groupName)
	_fpController = get_node(fpControllerPath)
	if _fpController == null:
		_fpController = get_tree().root.find_node("FPController", true, false)
	if _fpController == null:
		assert(false, "FPLandController: could not get referenced (or find) FPController node that is required")
	if not (_fpController is FPController):
		assert(false, "FPLandController: the FPController node must be of type FPController")
	reset()
	
func reset():
	if queueFreeLandPartsOnRemoval:
		for part in _landParts:
			assert(part.has_method("queue_free"),
				"FPLandController: if 'queueFreeLandPartsOnRemoval' is true, all land parts must have a 'queue_free()' method")
			part.queue_free()
	_landParts.clear()

func fpUpdate(fpController: FPController):
	fpLandUpdate()

func fpLandUpdate():
	if _freezeUpdates:
		return
	for child in get_children():
		assert(child.get("__is_FPLandBaseRenderer"),
			"FPLandController: all children of an FPLand node must be a 'FPLandBaseRenderer' subclass")
		child.fpLandUpdate()

func isPointOnLand(point: Vector2) -> bool:
	for part in _landParts:
		assert(part.has_method("containsPoint"),
			"FPLandController: to use 'isPointOnLand()', all land parts must contain a 'containsPoint(Vector2)' method")
		if part.containsPoint(point):
			return true
	return false

# NOTE: changing properties of a part after adding it will NOT trigger automatic updates
# instead if properties change, a manual update must be triggered
func addLandPart(part):
	_landParts.append(part)
	fpLandUpdate()

func _getFpController() -> FPController:
	return _fpController

func _getLandParts() -> Array:
	return _landParts

func _setFreezeUpdates(freeze: bool):
	_freezeUpdates = freeze
	if _freezeUpdates:
		fpLandUpdate()
		
func _getFreezeUpdates() -> bool:
	return _freezeUpdates
