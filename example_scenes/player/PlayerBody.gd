extends KinematicBody2D

export var moveSpeed: float = 80.0
export var eyeXRange := Vector2(-1, 4)
export var eyeYRange := Vector2(-1, 1)

var vel := Vector2()

onready var eyeSprite: Sprite = $EyeSprite
onready var legSnapMarkers: Node2D = $LegSnapMarkers

func _process(delta):
	if Input.is_action_pressed("player_move"):
		vel = _calcMoveDirVec() * moveSpeed * delta
	else:
		vel = Vector2.ZERO
	_animateEyes()
	_updateLegs()

func _physics_process(delta):
	move_and_collide(vel)

func _updateLegs():
	# TODO: snaps wrong with rotating world
	var dirVec := _calcMoveDirVec()
	var angle := dirVec.angle() - deg2rad(90)
	legSnapMarkers.rotation = angle if vel != Vector2.ZERO else 0
	legSnapMarkers.scale.x = -1 if dirVec.y < 0 else 1

func _animateEyes():
	if vel.y < 0:
		eyeSprite.visible = false
	else:
		eyeSprite.visible = true
		var dirVec := _calcMoveDirVec() # map [-1, 1] to eyeXRange values
		var dirX := dirVec.x + 1.0 # [0, 2]
		var eyeX := eyeXRange.x + (dirX / 2.0) * (eyeXRange.y - eyeXRange.x)
		var dirY := dirVec.y + 1.0
		var eyeY := eyeYRange.x + (dirY / 2.0) * (eyeYRange.y - eyeYRange.x)
		eyeSprite.position = Vector2(eyeX, eyeY)
		

func _calcMoveDirVec() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
