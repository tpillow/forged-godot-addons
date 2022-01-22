class_name Main
extends Node2D

onready var cam: Camera2D = $Camera2D
onready var fpController: FPController = $FPController
onready var fpLandController: FPLandController = $FPLandController

func _ready():
	randomize()
	_tmpGenerateCircles()
	
func _tmpGenerateCircles():
	var limit = 200.0
	fpLandController.freezeUpdates = true
	for i in range(100):
		var pos = Vector2(rand_range(-limit, limit), rand_range(-limit, limit))
		var part = FPSimpleLandCircle.new()
		part.setup(pos, rand_range(30.0, 90.0))
		fpLandController.addLandPart(part)
	fpLandController.freezeUpdates = false

func _process(delta):
	var camRotateSpeed = deg2rad(25.0)
	var camMoveSpeed = 80.0
	if Input.is_key_pressed(KEY_Q):
		cam.rotate(camRotateSpeed * delta)
	elif Input.is_key_pressed(KEY_E):
		cam.rotate(-camRotateSpeed * delta)
	
	# TODO: just debug, doesn't take into account angle or anything; also should use actions
#	if Input.is_key_pressed(KEY_A):
#		cam.position.x -= camMoveSpeed * delta
#	elif Input.is_key_pressed(KEY_D):
#		cam.position.x += camMoveSpeed * delta
#	if Input.is_key_pressed(KEY_W):
#		cam.position.y -= camMoveSpeed * delta
#	elif Input.is_key_pressed(KEY_S):
#		cam.position.y += camMoveSpeed * delta
