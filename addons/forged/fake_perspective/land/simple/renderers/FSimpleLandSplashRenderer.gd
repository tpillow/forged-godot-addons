class_name FSimpleLandSplashRenderer
extends FLandBaseRenderer
const __is_FSimpleLandSplashRenderer: bool = true

export var splashColor: Color = Color("ff7ec4c1")
export var minRadiusOffset: float = 2.0
export var maxRadiusOffset: float = 10.0
export var splashDuration: float = 2.0

var _tween: Tween = Tween.new()
var _radiusOffset: float = minRadiusOffset

func _ready():
	add_child(_tween)
	_tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	_startTween()

func _startTween():
	_tween.interpolate_property(self, "_radiusOffset", minRadiusOffset,
								maxRadiusOffset, splashDuration,
								Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.interpolate_property(self, "_radiusOffset", maxRadiusOffset,
								minRadiusOffset, splashDuration,
								Tween.TRANS_CUBIC, Tween.EASE_IN_OUT,
								splashDuration)
	_tween.start()

func _on_tween_all_completed():
	_startTween()

func _process(delta):
	fpLandUpdate()

func _baseDrawPart(part) -> bool:
	if part is FSimpleLandCircle:
		draw_circle(part.position +
			part.sideOffset.rotated(getFPerspController().rotation),
			part.radius + _radiusOffset, splashColor)
		return true
	return false
