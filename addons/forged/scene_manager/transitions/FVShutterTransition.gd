class_name FVShutterTransition
extends CanvasLayer

signal transitionComplete()

export var color: Color = Color.black
export var startDelay: float = 0.0
export var fadeOutTime: float = 1.0
export var fadePauseDelay: float = 0.0
export var fadeInTime: float = 1.0

var tweenType: int = Tween.TRANS_LINEAR
var tweenEaseType: int = Tween.EASE_IN

onready var topColorRect: ColorRect = $TopColorRect
onready var botColorRect: ColorRect = $BotColorRect
onready var tween: Tween = $Tween

func beginTransition(prev: Node, next: Node):
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, false)
	topColorRect.color = color
	botColorRect.color = color
	topColorRect.anchor_bottom = 0.0
	botColorRect.anchor_top = 1.0
	topColorRect.visible = false
	botColorRect.visible = false
	
	yield(get_tree().create_timer(startDelay), "timeout")
	
	topColorRect.visible = true
	botColorRect.visible = true
	tween.interpolate_property(topColorRect, "anchor_bottom", 0.0, 0.5,
		fadeOutTime, tweenType, tweenEaseType)
	tween.interpolate_property(botColorRect, "anchor_top", 1.0, 0.5,
		fadeOutTime, tweenType, tweenEaseType)
	tween.start()
	yield(tween, "tween_completed")
	
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(prev, false)
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, true)
	Forged.SceneManager.ensureCurrentCamsFor(next)
	yield(get_tree().create_timer(fadePauseDelay), "timeout")
	
	tween.interpolate_property(topColorRect, "anchor_bottom", 0.5, 0.0,
		fadeInTime, tweenType, tweenEaseType)
	tween.interpolate_property(botColorRect, "anchor_top", 0.5, 1.0,
		fadeInTime, tweenType, tweenEaseType)
	tween.start()
	yield(tween, "tween_completed")
	
	topColorRect.visible = false
	botColorRect.visible = false
	emit_signal("transitionComplete")
