extends Control

onready var fpsLabel: Label = $FPSLabel

func _process(delta):
	fpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())
