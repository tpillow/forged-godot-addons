class_name FLandBaseRenderer
extends Node2D
const __is_FLandBaseRenderer: bool = true

var _fLandController = null # Can't type this due to stupid dependency cycle that should have been fixed long long ago but for some reason isn't fixed in Godot which is really annoying and is probably the absolute worst part about this engine especially when people want to make decent plugins that will have autocompletion and such.

func _enter_tree():
	_fLandController = get_parent()
	assert(_fLandController.get("__is_FLandController"),
		"FLandBaseRenderer: the immediate of this must be an 'FLandController'")

func _exit_tree():
	_fLandController = null

func _draw():
	assert(_fLandController,
		"FLandBaseRenderer: in '_draw()', '_fLandController' was null! This shouldn't happen!")
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
