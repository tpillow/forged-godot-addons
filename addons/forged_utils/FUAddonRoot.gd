tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("FUNodeLine2D", "Line2D",
		preload("single_nodes/FUNodeLine2D.gd"), preload("forged_editor_icon.png"))

func _exit_tree():
	remove_custom_type("FUNodeLine2D")
