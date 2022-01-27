class_name FSnapNode
extends Node2D
const __is_FSnapNode: bool = true

export var homePath: NodePath
export var maxDistanceFromHome: float = 10.0
export var tweenHomeDuration: float = 0.1
export var startOffset: Vector2 = Vector2()
export(Array, NodePath) var _startSnapNodePathsToWaitStop: Array = []

var tweenTransType: int = Tween.TRANS_QUINT
var tweenEaseType: int = Tween.EASE_OUT

var snapNodesToWaitStop := []
var isMoving: bool setget , _getIsMoving

var _tween: Tween = Tween.new()

func _ready():
	snapNodesToWaitStop.append_array(_getStartSnapNodePathsToWaitStop())
	add_child(_tween)
	global_position = _getHomeNode().global_position + startOffset

func _process(delta):
	var distFromHome: float = global_position.distance_to(_getHomeNode().global_position)
	if distFromHome > maxDistanceFromHome:
		if _satisfiesNodesToWaitFor():
			_tweenToHome()

func _tweenToHome():
	var homePos: Vector2 = _getHomeNode().global_position
	var dirToHomePos: Vector2 = (homePos - global_position).normalized()
	
	_tween.stop_all()
	_tween.interpolate_property(self, "global_position",
		global_position, homePos,
		tweenHomeDuration, tweenTransType, tweenEaseType)
	_tween.start()

func _satisfiesNodesToWaitFor() -> bool:
	for snapNode in self.snapNodesToWaitStop:
		if snapNode.isMoving:
			return false
	return true

func _getHomeNode() -> Node2D:
	var node = get_node(homePath)
	assert(node and node is Node2D,
		"FSnapNode: the node pointed to by 'homePath' must be a subtype of Node2D")
	return node

func _getIsMoving() -> bool:
	return _tween.is_active()

func _getStartSnapNodePathsToWaitStop() -> Array:
	var ret := []
	for path in _startSnapNodePathsToWaitStop:
		var node := get_node(path)
		assert(node and node.get("__is_FSnapNode"),
			"FSnapNode: nodes in '_snapNodePathsToWaitStop' must also be of type FSnapNode")
		ret.append(node)
	return ret
