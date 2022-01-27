class_name ForgedGroupUtil
extends Object

signal nodeAddedToGroup(node, groupName)
signal nodeRemovedToGroup(node, groupName)

func addNodeToGroup(node: Node, groupName: String, persistent: bool = false):
	node.add_to_group(groupName, persistent)
	emit_signal("nodeAddedToGroup", node, groupName)

func removeNodeFromGroup(node: Node, groupName: String):
	node.remove_from_group(groupName)
	emit_signal("nodeRemovedFromGroup", node, groupName)
