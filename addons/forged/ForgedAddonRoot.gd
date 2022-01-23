tool
extends EditorPlugin

const PL_FORGED_EDITOR_ICON := preload("forged_editor_icon.png")

var _addedCustomTypeNames: Array = []

func _enter_tree():
	_initAllCustomTypes()

func _exit_tree():
	_deinitAllCustomTypes()

func _initAllCustomTypes():
	_initUtils()
	_initSnapPath()
	_initFakePerspective()

func _initUtils():
	_addCustomType("FNodeLine2D", "Line2D", preload("utils/FNodeLine2D.gd"))
	
func _initSnapPath():
	_addCustomType("FSnapNode", "Node2D", preload("snap_path/FSnapNode.gd"))

func _initFakePerspective():
	_addCustomType("FPerspController", "Node",
		preload("fake_perspective/controllers/FPerspController.gd"))
	_addCustomType("FPerspObj", "Node2D",
		preload("fake_perspective/controllers/FPerspObj.gd"))
	_addCustomType("FLandController", "Node2D",
		preload("fake_perspective/land/FLandController.gd"))
		
	_addCustomType("FPerspYSort", "Node2D",
		preload("fake_perspective/util/FPerspYSort.gd"))
		
	_addCustomType("FSimpleLandTopRenderer", "Node2D",
		preload("fake_perspective/land/simple/renderers/FSimpleLandTopRenderer.gd"))
	_addCustomType("FSimpleLandSideRenderer", "Node2D",
		preload("fake_perspective/land/simple/renderers/FSimpleLandSideRenderer.gd"))
	_addCustomType("FSimpleLandSplashRenderer", "Node2D",
		preload("fake_perspective/land/simple/renderers/FSimpleLandSplashRenderer.gd"))

func _addCustomType(name: String, nodeType: String, typePreload):
	assert(not (name in _addedCustomTypeNames))
	add_custom_type(name, nodeType, typePreload, PL_FORGED_EDITOR_ICON)
	_addedCustomTypeNames.append(name)

func _deinitAllCustomTypes():
	for customTypeName in _addedCustomTypeNames:
		remove_custom_type(customTypeName)
	_addedCustomTypeNames.clear()
