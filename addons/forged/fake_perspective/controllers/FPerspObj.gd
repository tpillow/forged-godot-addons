class_name FPerspObj
extends Node2D
const __is_FPerspObj: bool = true

export var fPerspControllerGroup: String = FPerspController.DEFAULT_PERSP_CONTROLLER_GROUP_NAME
export var relativeToParent: bool = true
export var relativeToNodePath: NodePath
export var setRelativeRotation: bool = false

var fPerspPosition: Vector2 setget , _getFPerspPosition

func _ready():
	Forged.GroupUtil.addNodeToGroup(self, fPerspControllerGroup)
	
func onFPerspControllerUpdated(fPerspController: FPerspController):
	var node: Node2D = _getFPerspObjRelativeToNode()
	rotation = fPerspController.rotation
	if setRelativeRotation:
		node.rotation = rotation

func _getFPerspPosition() -> Vector2:
	return _getFPerspObjRelativeToNode().global_position + position

func _getFPerspObjRelativeToNode() -> Node2D:
	if relativeToParent:
		assert(relativeToNodePath.is_empty(),
			"FPerspObj: if 'relativeToParent' is true, 'relativeToNodePath' must be empty")
		var node = get_parent()
		assert(node and node is Node2D,
			"FPerspObj: node pointed to by 'relativeToNodePath' must be a Node2D")
		return node
	elif not relativeToNodePath.is_empty():
		var node = get_node(relativeToNodePath)
		assert(node and node is Node2D,
			"FPerspObj: node pointed to by 'relativeToNodePath' must be a Node2D")
		return node
	else:
		assert(false, "FPerspObj: node must point to parent or have a valid 'relativeToNodePath' set")
	return null
