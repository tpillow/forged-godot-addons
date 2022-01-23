class_name FLandController
extends Node2D
const __is_FLandController: bool = true

export(NodePath) var fPerspControllerPath: NodePath
export var queueFreeLandPartsOnRemoval: bool = true

var _landParts: Array = []
var _freezeUpdates: bool = false

var freezeUpdates: bool setget _setFreezeUpdates, _getFreezeUpdates
var landParts: Array setget , _getLandParts

func _ready():
	reset()
	
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

func _getLandParts() -> Array:
	return _landParts

func _setFreezeUpdates(freeze: bool):
	_freezeUpdates = freeze
	if not _freezeUpdates:
		fpLandUpdate()
		
func _getFreezeUpdates() -> bool:
	return _freezeUpdates
