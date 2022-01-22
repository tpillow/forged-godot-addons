extends Node2D

export var homePath: NodePath
export var maxDistanceFromHome: float = 10.0
export var homeTweenTime: float = 0.1

onready var _tween: Tween = $Tween

func _process(delta):
	var homeNode := _getHomeNode()
	var dist := global_position.distance_to(homeNode.global_position)
	if dist > maxDistanceFromHome:
		_tweenToHome()

func _tweenToHome():
	_tween.stop_all()
	_tween.interpolate_property(self, "global_position",
		global_position, _getHomeNode().global_position,
		homeTweenTime, Tween.TRANS_QUINT, Tween.EASE_OUT)
	_tween.start()

func _getHomeNode() -> Node2D:
	var node = get_node(homePath)
	assert(node and node is Node2D, "home node must be valid node2d")
	return node
