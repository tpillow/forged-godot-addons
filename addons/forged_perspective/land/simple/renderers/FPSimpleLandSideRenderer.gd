class_name FPSimpleLandSideRenderer
extends FPLandBaseRenderer

export var radiusMultiplier: float = 1.0

func _baseDrawPart(part) -> bool:
	if part is FPSimpleLandCircle:
		draw_circle(part.position + part.sideOffset.rotated(getFpController().rotation),
			part.radius * radiusMultiplier, part.sideColor)
		return true
	return false
