extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("goto_shader_scene"):
		Forged.SceneManager.pop(Forged.Preloads.PL_FColorFadeTransition.instance())
