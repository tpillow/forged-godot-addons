extends Control

onready var fpsLbl: Label = $FPSLabel

func _process(delta):
	fpsLbl.text = "FPS: " + str(Engine.get_frames_per_second())
