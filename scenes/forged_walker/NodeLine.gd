extends Line2D

export var pointAPath: NodePath
export var pointBPath: NodePath

func _process(delta):
	points[0] = get_node(pointAPath).global_position
	points[1] = get_node(pointBPath).global_position

