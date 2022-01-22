tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("FPController", "Node",
		preload("controller/FPController.gd"), preload("forged_editor_icon.png"))
	add_custom_type("FPLandController", "Node2D",
		preload("land/FPLandController.gd"), preload("forged_editor_icon.png"))
	
	add_custom_type("FPSimpleLandTopRenderer", "Node2D",
		preload("land/simple/renderers/FPSimpleLandTopRenderer.gd"), preload("forged_editor_icon.png"))
	add_custom_type("FPSimpleLandSideRenderer", "Node2D",
		preload("land/simple/renderers/FPSimpleLandSideRenderer.gd"), preload("forged_editor_icon.png"))
	add_custom_type("FPSimpleLandSplashRenderer", "Node2D",
		preload("land/simple/renderers/FPSimpleLandSplashRenderer.gd"), preload("forged_editor_icon.png"))

func _exit_tree():
	remove_custom_type("FPController")
	remove_custom_type("FPLandController")
	
	remove_custom_type("FPSimpleLandTopRenderer")
	remove_custom_type("FPSimpleLandSideRenderer")
	remove_custom_type("FPSimpleLandSplashRenderer")
