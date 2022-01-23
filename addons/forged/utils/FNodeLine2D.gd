class_name FNodeLine2D
extends Line2D
const __is_FNodeLine2D: bool = true

export var updateOnProcess: bool = true
export var updateOnPhysicsProcess: bool = false
export(Array, NodePath) var _nodePaths: Array = []

var nodePaths: Array setget _setNodePaths, _getNodePaths

func _ready():
	updateLinePointsFromNodePaths()

func _process(delta):
	if updateOnProcess:
		updateLinePointsFromNodePaths()
		
func _physics_process(delta):
	if updateOnPhysicsProcess:
		updateLinePointsFromNodePaths()

func updateLinePointsFromNodePaths():
	clear_points()
	for path in _nodePaths:
		add_point(_safeGetNode2D(path).global_position)

func _safeGetNode2D(nodePath: NodePath) -> Node2D:
	var node = get_node(nodePath)
	assert(node and node is Node2D,
		"FNodeLine2D: nodes in '_nodePaths' must be a subtype of Node2D")
	return node

func _setNodePaths(nodePaths: Array):
	_nodePaths = nodePaths
	updateLinePointsFromNodePaths()
	
func _getNodePaths() -> Array:
	return _nodePaths
