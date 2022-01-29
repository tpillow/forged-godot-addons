class_name FCam2D
extends Node2D

export var startCamAsCurrentOnReady: bool = true
export var maxShakeMagnitude: float = 8.0
export var shakeDampening: float = 12.0
export var maxShakeXOffset := Vector2(-10, 10)
export var maxShakeYOffset := Vector2(-10, 10)
export var maxShakeRotationDegs := Vector2(-5, 5)
export var _zoom: Vector2 = Vector2(1, 1)
export var smoothZoomEnabled: bool = false
export var smoothZoomDuration: float = 1.5

var smoothZoomTweenType: int = Tween.TRANS_LINEAR
var smoothZoomTweenEase: int = Tween.EASE_IN

var followNode: Node2D = null
var _shakeMagnitude: float = 0.0

var zoom: Vector2 setget _setZoom, _getZoom

onready var cam: Camera2D = $Cam
onready var zoomTween: Tween = $ZoomTween

func _ready():
	if startCamAsCurrentOnReady:
		cam.current = true
	cam.zoom = _zoom

func _process(delta):
	_processCamMove(delta)
	_processShake(delta)
	
func _processCamMove(delta: float):
	if followNode:
		# TODO: add smoothing? Or let camera settings handle that?
		global_position = followNode.global_position
	
func _processShake(delta: float):
	if _shakeMagnitude > 0:
		# Set random offset and rotation
		var strength := _shakeMagnitude / maxShakeMagnitude
		cam.position.x = Forged.Util.randfFromVec2(maxShakeXOffset) * strength
		cam.position.y = Forged.Util.randfFromVec2(maxShakeYOffset) * strength
		cam.rotation_degrees = Forged.Util.randfFromVec2(maxShakeRotationDegs) * strength
		# Reduce shaking
		shake(-shakeDampening * delta)

	if _shakeMagnitude <= 0:
		cam.position = Vector2.ZERO

func shake(amount: float):
	_shakeMagnitude = clamp(_shakeMagnitude + amount, 0.0, maxShakeMagnitude)

func stopShake():
	_shakeMagnitude = 0.0

func setZoomNoSmooth(level: Vector2):
	zoomTween.stop_all()
	_zoom = level
	cam.zoom = _zoom

##### Getters Setters

func _setZoom(level: Vector2):
	_zoom = level
	if smoothZoomEnabled:
		zoomTween.stop_all()
		zoomTween.interpolate_property(cam, "zoom", cam.zoom, _zoom,
			smoothZoomDuration, smoothZoomTweenType, smoothZoomTweenEase)
		zoomTween.start()
	else:
		cam.zoom = _zoom

func _getZoom() -> Vector2:
	return _zoom
