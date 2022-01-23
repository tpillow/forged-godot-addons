class_name FPSimpleLandCircle
extends Node

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
