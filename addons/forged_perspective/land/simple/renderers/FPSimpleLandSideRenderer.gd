class_name FPSimpleLandSideRenderer
extends FPSimpleLandBaseRenderer

func _baseDrawPart(part) -> bool:
	if part is FPSimpleLandCircle:
		draw_circle(part.position + part.sideOffset, part.radius, part.sideColor)
		return true
	return false
