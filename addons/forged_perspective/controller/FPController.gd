class_name FPController
extends Node

const FORGED_CONTROLLERS_GROUP: String = "fp_controllers"
const DEFAULT_FORGED_PERSPECTIVE_GROUP: String = "fp"

export var _groupName: String = DEFAULT_FORGED_PERSPECTIVE_GROUP
export var _enabled: bool = true
export var _rotation: float = 0.0

var enabled: bool setget _setEnabled, _getEnabled
var rotation: float setget _setRotation, _getRotation

func _ready():
	add_to_group(FORGED_CONTROLLERS_GROUP)
	
func _enter_tree():
	update()

func update():
	if _enabled:
		var nodes: Array = get_tree().get_nodes_in_group(_groupName)
		for node in nodes:
			assert(node.has_method("fpUpdate"),
				"FPController: nodes in group '" + _groupName + "' must have a 'fpUpdate()' method")
			node.fpUpdate()

func _setEnabled(enabled: bool):
	if _enabled == enabled:
		return
	_enabled = enabled
	update()
	
func _getEnabled() -> bool:
	return _enabled

func _setRotation(rotation: float):
	if _rotation == rotation:
		return
	_rotation = rotation
	update()
	
func _getRotation() -> float:
	return _rotation
