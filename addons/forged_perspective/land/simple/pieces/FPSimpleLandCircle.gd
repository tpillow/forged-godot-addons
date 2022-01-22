class_name FPSimpleLandCircle
extends Node

var position: Vector2 = Vector2()
var radius: float = 1.0
var sideOffset: Vector2 = Vector2(0, 10)
var topColor: Color = Color("ffc0c741")
var sideColor: Color = Color("ff9a6348")

func setup(position: Vector2, radius: float, sideOffset: Vector2 = Vector2(0, 10),
		topColor: Color = Color("ffc0c741"), sideColor: Color = Color("ff9a6348")):
	self.position = position
	self.radius = radius
	self.sideOffset = sideOffset
	self.topColor = topColor
	self.sideColor = sideColor
