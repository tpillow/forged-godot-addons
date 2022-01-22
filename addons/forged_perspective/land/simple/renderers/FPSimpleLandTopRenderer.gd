# TODO: make a base class for SimpleRenderers, they share a lot of code, really just need _baseDrawPart here
class_name FPSimpleLandTopRenderer
extends FPSimpleLandBaseRenderer

func _baseDrawPart(part) -> bool:
	if part is FPSimpleLandCircle:
		draw_circle(part.position, part.radius, part.topColor)
		return true
	return false
