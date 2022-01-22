class_name FPSimpleLandTopRenderer
extends FPLandBaseRenderer

func _baseDrawPart(part) -> bool:
	if part is FPSimpleLandCircle:
		draw_circle(part.position, part.radius, part.topColor)
		return true
	return false
