extends KinematicBody2D

export var moveSpeed: float = 80.0

var vel := Vector2()

func _process(delta):
	rotation = _calcMoveDirVec().angle() + deg2rad(90)
	if Input.is_action_pressed("player_move"):
		vel = _calcMoveDirVec() * moveSpeed * delta
	else:
		vel = Vector2.ZERO

func _physics_process(delta):
	move_and_collide(vel)

func _calcMoveDirVec() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
