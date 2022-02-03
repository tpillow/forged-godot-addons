class_name FHShutterTransition
extends CanvasLayer

signal transitionComplete()

export var color: Color = Color.black
export var startDelay: float = 0.0
export var fadeOutTime: float = 1.0
export var fadePauseDelay: float = 0.0
export var fadeInTime: float = 1.0

var tweenType: int = Tween.TRANS_LINEAR
var tweenEaseType: int = Tween.EASE_IN

onready var leftColorRect: ColorRect = $LeftColorRect
onready var rightColorRect: ColorRect = $RightColorRect
onready var tween: Tween = $Tween

func beginTransition(prev: Node, next: Node):
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, false)
	leftColorRect.color = color
	rightColorRect.color = color
	leftColorRect.anchor_right = 0.0
	rightColorRect.anchor_left = 1.0
	leftColorRect.visible = false
	rightColorRect.visible = false
	
	yield(get_tree().create_timer(startDelay), "timeout")
	
	leftColorRect.visible = true
	rightColorRect.visible = true
	tween.interpolate_property(leftColorRect, "anchor_right", 0.0, 0.5,
		fadeOutTime, tweenType, tweenEaseType)
	tween.interpolate_property(rightColorRect, "anchor_left", 1.0, 0.5,
		fadeOutTime, tweenType, tweenEaseType)
	tween.start()
	yield(tween, "tween_completed")
	
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(prev, false)
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, true)
	Forged.SceneManager.ensureCurrentCamsFor(next)
	yield(get_tree().create_timer(fadePauseDelay), "timeout")
	
	tween.interpolate_property(leftColorRect, "anchor_right", 0.5, 0.0,
		fadeInTime, tweenType, tweenEaseType)
	tween.interpolate_property(rightColorRect, "anchor_left", 0.5, 1.0,
		fadeInTime, tweenType, tweenEaseType)
	tween.start()
	yield(tween, "tween_completed")
	
	leftColorRect.visible = false
	rightColorRect.visible = false
	emit_signal("transitionComplete")
