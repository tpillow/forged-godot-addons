class_name FPLandController
extends Node
var __is_FPLandController: bool = true

export var _groupName: String = FPController.DEFAULT_FORGED_PERSPECTIVE_GROUP
export var queueFreeLandPartsOnRemoval: bool = true

var _landParts: Array = []
var _freezeUpdates: bool = false

var freezeUpdates: bool setget _setFreezeUpdates, _getFreezeUpdates
var landParts: Array setget , _getLandParts

func _enter_tree():
	add_to_group(_groupName)
	reset()
	
func reset():
	if queueFreeLandPartsOnRemoval:
		for part in _landParts:
			assert(part.has_method("queue_free"),
				"FPLandController: if 'queueFreeLandPartsOnRemoval' is true, all land parts must have a 'queue_free()' method")
			part.queue_free()
	_landParts.clear()

func fpUpdate():
	update()

func update():
	if _freezeUpdates:
		return
	for child in get_children():
		# TODO: maybe have the renderers have a priority, instead of depending on tree order
		assert(child.has_method("fpLandUpdate"),
			"FPLandController: in all children of an FPLand node must have a 'fpLandUpdate()' method")
		child.fpLandUpdate()

# NOTE: changing properties of a part after adding it will NOT trigger automatic updates
# instead if properties change, a manual update must be triggered
func addLandPart(part):
	_landParts.append(part)
	update()

func _getLandParts() -> Array:
	return _landParts

func _setFreezeUpdates(freeze: bool):
	_freezeUpdates = freeze
	if _freezeUpdates:
		update()
		
func _getFreezeUpdates() -> bool:
	return _freezeUpdates
