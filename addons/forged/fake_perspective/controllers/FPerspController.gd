class_name FPerspController
extends Node
const __is_FPerspController: bool = true

const DEFAULT_PERSP_CONTROLLER_GROUP_NAME: String = "fpersp_controlled"

export var enabled: bool = true
export var _controllingGroupName: String = DEFAULT_PERSP_CONTROLLER_GROUP_NAME
export var _rotation: float = 0.0
export var _cameraToFollowPath: NodePath
export var _followCameraRotation: bool = false

var rotation: float setget _setRotation, _getRotation
var rotationDegrees: float setget _setRotationDegrees, _getRotationDegrees

func _ready():
	Forged.GroupUtil.connect("nodeAddedToGroup", self, "_onNodeAddedToGroup")
	connect("rotationChanged", self, "_onRotationChanged")

func _process(delta):
	if _followCameraRotation:
		var cam: Camera2D = get_node(_cameraToFollowPath)
		assert(cam and cam is Camera2D,
			"FPerspController: if '_followCameraRotation' is true, the camera path must point to a valid Camera2D")
		self.rotation = cam.rotation

func emitControllerUpdate():
	for node in get_tree().get_nodes_in_group(_controllingGroupName):
		node.onFPerspControllerUpdated(self)

##### Group Management

func _onNodeAddedToGroup(node: Node, groupName: String):
	if groupName == _controllingGroupName:
		node.onFPerspControllerUpdated(self)

##### Getters Setters

func _setRotationDegrees(rotation: float):
	self.rotation = deg2rad(rotation)

func _getRotationDegrees() -> float:
	return rad2deg(self.rotation)

func _setRotation(rotation: float):
	if _rotation == rotation: return
	_rotation = rotation
	emitControllerUpdate()

func _getRotation() -> float:
	return _rotation
