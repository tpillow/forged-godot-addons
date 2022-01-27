class_name FLandBaseRenderer
extends Node2D
const __is_FLandBaseRenderer: bool = true

var _fLandController = null # Can't type this, due to gdscript :(

func _enter_tree():
	_fLandController = get_parent()
	assert(_fLandController.get("__is_FLandController"),
		"FLandBaseRenderer: the immediate of this must be an 'FLandController'")

func _exit_tree():
	_fLandController = null

func _draw():
	for part in _fLandController.landParts:
		var baseSuccess := _baseDrawPart(part)
		if not baseSuccess:
			assert(false,
				"FLandBaseRenderer: in '_draw()', unknown part type encountered. You may need a custom renderer to extend this.")

func _baseDrawPart(part) -> bool:
	assert(false, "FLandBaseRenderer: '_baseDrawPart(part)' must be implemented")
	return false

func fpLandUpdate():
	update()
