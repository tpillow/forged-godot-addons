class_name FPLandBaseRenderer
extends Node2D
var __is_FPLandBaseRenderer: bool = true

var _fpLandController = null # Can't type this due to stupid dependency cycle that should have been fixed long long ago but for some reason isn't fixed in Godot which is really annoying and is probably the absolute worst part about this engine especially when people want to make decent plugins that will have autocompletion and such.

func _enter_tree():
	_fpLandController = get_parent()
	assert(_fpLandController.get("__is_FPLandController"),
		"FPLandBaseRenderer: the immediate of this must be an 'FPLandController'")

func _exit_tree():
	_fpLandController = null

func _draw():
	assert(_fpLandController,
		"FPLandBaseRenderer: in '_draw()', '_fpLandController' was null! This shouldn't happen!")
	for part in _fpLandController.landParts:
		var baseSuccess := _baseDrawPart(part)
		if not baseSuccess:
			assert(false,
				"FPLandBaseRenderer: in '_draw()', unknown part type encountered. You may need a custom renderer to extend this.")

func _baseDrawPart(part) -> bool:
	assert(false, "FPLandBaseRenderer: '_baseDrawPart(part)' must be implemented")
	return false

func fpLandUpdate():
	update()
	
func getFpController() -> FPController:
	return _fpLandController.fpController
