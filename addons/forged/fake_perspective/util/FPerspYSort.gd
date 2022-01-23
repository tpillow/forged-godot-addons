class_name FPerspYSort
extends Node2D
const __is_FPerspYSort: bool = true
# TODO: allow children y-sorts to have sort logic controlled by parent y-sort (like real YSort node)

export var _fPerspControllerPath: NodePath
export var _enabled: bool = true

var enabled: bool setget _setEnabled, _getEnabled

func _enter_tree():
	resort()

func _process(delta):
	resort() # TODO: is there a way to not do this every frame?

func resort():
	if not _enabled:
		return
	var children: Array = get_children()
	children.sort_custom(self, "_perspSorter")
	for i in range(children.size()):
		move_child(children[i], i)

func _perspSorter(a, b) -> bool:
	var aSortable := _getSortable(a)
	var bSortable := _getSortable(b)
	return (aSortable.fPerspPosition.rotated(-aSortable.rotation).y <
		bSortable.fPerspPosition.rotated(-bSortable.rotation).y)

func _getSortable(obj: Node) -> FPerspObj:
	if obj is FPerspObj:
		return obj as FPerspObj
	var objChildren: Array = obj.get_children()
	for child in objChildren:
		if child is FPerspObj:
			return child
	assert(false,
		"FPerspYSort: in '_getSortable', could not find FPerspObj as child of node '" + str(obj) + "'")
	return null

func _setEnabled(enabled: bool):
	if _enabled == enabled:
		return
	_enabled = enabled
	# resort(_getFPerspController()) # Probably no need, since next process will do this

func _getEnabled() -> bool:
	return _enabled
