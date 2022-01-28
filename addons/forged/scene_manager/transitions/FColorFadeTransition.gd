class_name FColorFadeTransition
extends CanvasLayer

signal transitionComplete()

export var color: Color = Color.black
export var startDelay: float = 0.0
export var fadeOutTime: float = 1.0
export var fadePauseDelay: float = 0.0
export var fadeInTime: float = 1.0

onready var colorRect: ColorRect = $ColorRect
onready var tween: Tween = $Tween

func beginTransition(prev: Node, next: Node):
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, false)
	var transparentColor: Color = Color(color.to_html())
	transparentColor.a = 0.0
	colorRect.color = transparentColor
	colorRect.visible = false
	
	yield(get_tree().create_timer(startDelay), "timeout")
	
	colorRect.visible = true
	tween.interpolate_property(colorRect, "color", transparentColor, color,
		fadeOutTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(prev, false)
	Forged.SceneManager.setNodeVisibleAndChildCanvasLayers(next, true)
	Forged.SceneManager.ensureCurrentCamsFor(next)
	yield(get_tree().create_timer(fadePauseDelay), "timeout")
	
	tween.interpolate_property(colorRect, "color", color, transparentColor,
		fadeInTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	colorRect.visible = false
	emit_signal("transitionComplete")
