tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("FSPSnapNode", "Node2D",
		preload("snap/FSPSnapNode.gd"), preload("forged_editor_icon.png"))

func _exit_tree():
	remove_custom_type("FSPSnapNode")
