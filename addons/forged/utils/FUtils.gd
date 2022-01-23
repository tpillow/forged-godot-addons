class_name FUtils
extends Node
const __is_FUtils: bool = true

static func randfFromVec2(vecRange: Vector2, rng: RandomNumberGenerator = null) -> float:
	if rng:
		return rng.randf_range(vecRange.x, vecRange.y)
	return rand_range(vecRange.x, vecRange.y)

static func randVec2(xRange: Vector2, yRange: Vector2, rng: RandomNumberGenerator = null) -> Vector2:
	return Vector2(randfFromVec2(xRange, rng), randfFromVec2(yRange, rng))
