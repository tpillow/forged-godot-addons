class_name FPSimpleLandSideRenderer
extends FPLandBaseRenderer

func _baseDrawPart(part) -> bool:
	if part is FPSimpleLandCircle:
		draw_circle(part.position + part.sideOffset.rotated(getFpController().rotation),
			part.radius, part.sideColor)
		return true
	return false
