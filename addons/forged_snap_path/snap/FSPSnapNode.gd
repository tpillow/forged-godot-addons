class_name FSPSnapNode
extends Node2D

export var homePath: NodePath
export var maxDistanceFromHome: float = 10.0
export var tweenHomeDuration: float = 0.1

var tweenTransType: int = Tween.TRANS_QUINT
var tweenEaseType: int = Tween.EASE_OUT

var _tween: Tween = Tween.new()

func _ready():
	add_child(_tween)

func _process(delta):
	var distFromHome: float = global_position.distance_to(_getHomeNode().global_position)
	if distFromHome > maxDistanceFromHome:
		_tweenToHome()

func _tweenToHome():
	_tween.stop_all()
	_tween.interpolate_property(self, "global_position",
		global_position, _getHomeNode().global_position,
		tweenHomeDuration, tweenTransType, tweenEaseType)
	_tween.start()

func _getHomeNode() -> Node2D:
	var node = get_node(homePath)
	assert(node and node is Node2D,
		"FSPSnapNode: the node pointed to by 'homePath' must be a subtype of Node2D")
	return node
