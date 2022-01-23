class_name FSimpleLandSideRenderer
extends FLandBaseRenderer
const __is_FSimpleLandSideRenderer: bool = true

export var radiusMultiplier: float = 1.0

func _baseDrawPart(part) -> bool:
	if part is FSimpleLandCircle:
		draw_circle(part.position + 
			part.sideOffset.rotated(getFPerspController().rotation),
			part.radius * radiusMultiplier, part.sideColor)
		return true
	return false
