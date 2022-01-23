class_name FPerspYSort
extends Node2D
const __is_FPerspYSort: bool = true

export var _fPerspControllerPath: NodePath
export var _enabled: bool = true

var enabled: bool setget _setEnabled, _getEnabled
var _fPerspController: FPerspController = null

func _enter_tree():
	_fPerspController = _getFPerspController()
	resort()

func _process(delta):
	_fPerspController = _getFPerspController()
	resort() # TODO: is there a way to not do this every frame?

func resort():
	if not _enabled:
		return
	var children: Array = get_children()
	children.sort_custom(self, "_perspSorter")
	for i in range(children.size()):
		move_child(children[i], i)
	
func _perspSorter(a, b) -> bool:
	if not _isSortableType(a) or not _isSortableType(b):
		return false
	var rotation: float = _fPerspController.rotation
	return a.position.rotated(rotation).y < b.position.rotated(rotation).y

func _getFPerspController() -> FPerspController:
	var fPerspController = get_node(_fPerspControllerPath)
	if fPerspController == null:
		# TODO: don't do this, errors if it can't find automatically, shouldn't do every frame either
		fPerspController = get_tree().root.find_node("FPerspController", true, false)
	if fPerspController == null:
		assert(false, "FPerspYSort: could not get referenced (or find) FPerspController node that is required")
	if not (fPerspController is FPerspController):
		assert(false, "FPerspYSort: the FPerspController node must be of type FPerspController")
	return fPerspController

func _isSortableType(obj):
	return obj is CanvasItem # TODO: should we check if in perspective group?

func _setEnabled(enabled: bool):
	if _enabled == enabled:
		return
	_enabled = enabled
	# resort(_getFPerspController()) # Probably no need, since next process will do this

func _getEnabled() -> bool:
	return _enabled
