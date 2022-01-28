class_name FSimpleLandCircle
extends Node

const POLYGON_STEPS: int = 70

var position: Vector2 = Vector2()
var radius: float = 1.0
var sideOffset: Vector2 = Vector2()
var topColor: Color = Color.green
var sideColor: Color = Color.brown

func setup(position: Vector2, radius: float, sideOffset: Vector2 = Vector2(0, 15),
		topColor: Color = Color("ffc0c741"), sideColor: Color = Color("ff9a6348")):
	self.position = position
	self.radius = radius
	self.sideOffset = sideOffset
	self.topColor = topColor
	self.sideColor = sideColor

func containsPoint(point: Vector2) -> bool:
	return position.distance_to(point) <= radius

func createNavigationPolygon() -> NavigationPolygon:
	var ret := NavigationPolygon.new()
	ret.add_outline(PoolVector2Array(getOutlinePolygonPoints()))
	ret.make_polygons_from_outlines()
	return ret

func getOutlinePolygonPoints() -> Array:
	var ret := []
	var angle := 0.0
	for i in range(POLYGON_STEPS):
		var angleVec := Vector2(cos(angle), sin(angle))
		ret.append(position + angleVec * radius)
		angle += 2 * PI / POLYGON_STEPS
	ret.append(ret[0])
	return ret
