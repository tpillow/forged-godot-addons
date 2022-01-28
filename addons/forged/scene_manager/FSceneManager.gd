class_name FSceneManager
extends Node

signal transitionComplete()

var _sceneTree: SceneTree = null
var _sceneStack := []
var _curCameras := {}

func initialize(sceneTree: SceneTree):
	_sceneTree = sceneTree
	var startNode := _sceneTree.current_scene
	if startNode:
		_sceneTree.root.remove_child(startNode)
		push(startNode)
	
func push(next: Node, transition: Node = null):
	var prev := peekScene(0)
	_sceneTree.root.add_child(next)
	_curCameras[next] = _getCurrentCams(next)
	if transition:
		_doTransition(transition, prev, next)
		yield(self, "transitionComplete")
	else:
		setNodeVisibleAndChildCanvasLayers(next, true)
	if prev:
		_sceneTree.root.remove_child(prev)
	_sceneStack.push_back(next)
	
func pop(transition: Node = null):
	var prev := peekScene(0)
	var next := peekScene(1)
	if next:
		_sceneTree.root.add_child(next)
	if transition:
		_doTransition(transition, prev, next)
		yield(self, "transitionComplete")
	else:
		setNodeVisibleAndChildCanvasLayers(next, true)
	_sceneTree.root.remove_child(prev)
	_curCameras.erase(prev)
	prev.free()
	_sceneStack.pop_back()
	ensureCurrentCamsFor(next)

func peekScene(idx: int) -> Node:
	if _sceneStack.size() <= idx:
		return null
	return _sceneStack[_sceneStack.size() - idx - 1]

func ensureCurrentCamsFor(node: Node):
	if _curCameras.has(node):
		for cam in _curCameras[node]:
			cam.current = true

func _getCurrentCams(node: Node) -> Array:
	if not node: return []
	var ret := []
	if node is Camera2D and node.current:
		ret.append(node)
	for child in node.get_children():
		ret.append_array(_getCurrentCams(child))
	return ret
	
func setNodeVisibleAndChildCanvasLayers(node: Node, visible: bool):
	if not node: return
	if node.get("visible") != null:
		node.visible = visible
	setCanvasLayerChildVisible(node, visible)
	
func setCanvasLayerChildVisible(node: Node, visible: bool):
	if not node: return
	if node is CanvasLayer:
		if node.get_child_count() > 0:
			var child := node.get_child(0)
			if child is Control or child is Node2D:
				child.visible = visible
	for child in node.get_children():
		setCanvasLayerChildVisible(child, visible)

func _doTransition(transition: Node, prev: Node, next: Node):
	if prev:
		prev.pause_mode = Node.PAUSE_MODE_STOP
	if next:
		next.pause_mode = Node.PAUSE_MODE_STOP
	transition.pause_mode = Node.PAUSE_MODE_PROCESS
	_sceneTree.root.add_child(transition)
	_sceneTree.paused = true
	ensureCurrentCamsFor(prev)
	transition.beginTransition(prev, next)
	yield(transition, "transitionComplete")
	transition.queue_free()
	if prev:
		prev.pause_mode = Node.PAUSE_MODE_INHERIT
	if next:
		next.pause_mode = Node.PAUSE_MODE_INHERIT
	_sceneTree.paused = false
	emit_signal("transitionComplete")
