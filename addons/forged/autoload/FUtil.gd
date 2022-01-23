extends Node

var fPerspController: FPerspController setget , _getFPerspController

func randfFromVec2(vecRange: Vector2, rng: RandomNumberGenerator = null) -> float:
	if rng:
		return rng.randf_range(vecRange.x, vecRange.y)
	return rand_range(vecRange.x, vecRange.y)

func randVec2(xRange: Vector2, yRange: Vector2, rng: RandomNumberGenerator = null) -> Vector2:
	return Vector2(randfFromVec2(xRange, rng), randfFromVec2(yRange, rng))

func _getFPerspController() -> FPerspController:
	# TODO: I don't like this singleton/single-instance design. Easiest for now though.
	var nodes: Array = get_tree().get_nodes_in_group(FPerspController.FORGED_CONTROLLERS_GROUP)
	assert(nodes.size() == 1,
		"FUtil: '_getFPerspController' expects exactly one FPerspController to exist in the project")
	return nodes[0]
