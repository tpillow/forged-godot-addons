class_name FPerspController
extends Node
const __is_FPerspController: bool = true

const FORGED_CONTROLLERS_GROUP: String = "forged_persp_controller"

export var enabled: bool = true
export var rotation: float = 0.0
export var _cameraToFollowPath: NodePath
export var _followCameraRotation: bool = false

var rotationDegrees: float setget _setRotationDegrees, _getRotationDegrees

func _ready():
	add_to_group(FORGED_CONTROLLERS_GROUP)

func _process(delta):
	if _followCameraRotation:
		var cam: Camera2D = get_node(_cameraToFollowPath)
		assert(cam and cam is Camera2D,
			"FPerspController: if '_followCameraRotation' is true, the camera path must point to a valid Camera2D")
		self.rotation = cam.rotation

func _setRotationDegrees(rotation: float):
	self.rotation = deg2rad(rotation)
	
func _getRotationDegrees() -> float:
	return rad2deg(self.rotation)
