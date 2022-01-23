class_name FSimpleLandTopRenderer
extends FLandBaseRenderer
const __is_FSimpleLandTopRenderer: bool = true

func _baseDrawPart(part) -> bool:
	if part is FSimpleLandCircle:
		draw_circle(part.position, part.radius, part.topColor)
		return true
	return false
