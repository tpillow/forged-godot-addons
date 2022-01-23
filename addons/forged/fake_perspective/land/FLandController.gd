class_name FLandController
extends Node2D
const __is_FLandController: bool = true

export var _groupName: String = FPerspController.DEFAULT_FORGED_PERSPECTIVE_GROUP
export(NodePath) var fPerspControllerPath: NodePath
export var queueFreeLandPartsOnRemoval: bool = true

var _landParts: Array = []
var _freezeUpdates: bool = false
var _fPerspController: FPerspController = null

var freezeUpdates: bool setget _setFreezeUpdates, _getFreezeUpdates
var landParts: Array setget , _getLandParts
var fPerspController: FPerspController setget , _getFPerspController

func _enter_tree():
	add_to_group(_groupName)
	fPerspController = get_node(fPerspControllerPath)
	if _fPerspController == null:
		# TODO: don't do this, errors if it can't find automatically, shouldn't do every frame either
		_fPerspController = get_tree().root.find_node("FPerspController", true, false)
	if _fPerspController == null:
		assert(false, "FLandController: could not get referenced (or find) FPerspController node that is required")
	if not (_fPerspController is FPerspController):
		assert(false, "FLandController: the FPerspController node must be of type FPerspController")
	reset()
	
func reset():
	if queueFreeLandPartsOnRemoval:
		for part in _landParts:
			assert(part.has_method("queue_free"),
				"FLandController: if 'queueFreeLandPartsOnRemoval' is true, all land parts must have a 'queue_free()' method")
			part.queue_free()
	_landParts.clear()
	fpUpdate(_fPerspController)

func fpUpdate(fPerspController: FPerspController):
	fpLandUpdate()

func fpLandUpdate():
	if _freezeUpdates:
		return
	for child in get_children():
		assert(child.get("__is_FLandBaseRenderer"),
			"FLandController: all children of an FPLand node must be a 'FLandBaseRenderer' subclass")
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

func _getFPerspController() -> FPerspController:
	return _fPerspController

func _getLandParts() -> Array:
	return _landParts

func _setFreezeUpdates(freeze: bool):
	_freezeUpdates = freeze
	if not _freezeUpdates:
		fpLandUpdate()
		
func _getFreezeUpdates() -> bool:
	return _freezeUpdates
