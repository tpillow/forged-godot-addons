class_name FSceneManager
extends Node

signal transitionComplete()

var _sceneTree: SceneTree = null
var _sceneStack := []

func initialize(sceneTree: SceneTree):
	_sceneTree = sceneTree
	var startNode := _sceneTree.current_scene
	if startNode:
		_sceneTree.root.remove_child(startNode)
		push(startNode)
	
func push(next: Node, transition: Node = null):
	var prev := peekScene(0)
	_sceneTree.root.add_child(next)
	if transition:
		_doTransition(transition, prev, next)
		yield(self, "transitionComplete")
	else:
		setNodeVisibleAndChildCanvasLayers(next, true)
	if prev:
		_sceneTree.root.remove_child(prev)
	ensureCamsCurrent(next)
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
	prev.free()
	ensureCamsCurrent(next)
	_sceneStack.pop_back()

func peekScene(idx: int) -> Node:
	if _sceneStack.size() <= idx:
		return null
	return _sceneStack[_sceneStack.size() - idx - 1]

func ensureCamsCurrent(node: Node):
	# Needed when switching between scenes with their own cameras
	if not node: return
	if node is Camera2D:
		node.current = not node.current
		node.current = not node.current
	for child in node.get_children():
		ensureCamsCurrent(child)
	
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
	ensureCamsCurrent(prev)
	transition.beginTransition(prev, next)
	yield(transition, "transitionComplete")
	transition.queue_free()
	if prev:
		prev.pause_mode = Node.PAUSE_MODE_INHERIT
	if next:
		next.pause_mode = Node.PAUSE_MODE_INHERIT
	_sceneTree.paused = false
	emit_signal("transitionComplete")
