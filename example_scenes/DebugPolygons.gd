extends Node2D

var _polys := []
	
func setPolys(polys: Array):
	_polys = polys
	update()
	
func _draw():
	for poly in _polys:
		var verts = poly.get_vertices()
		for vert in verts:
			draw_circle(vert, 2, Color.red)
