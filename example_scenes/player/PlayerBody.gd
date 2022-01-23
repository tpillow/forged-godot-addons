extends KinematicBody2D

export var moveSpeed: float = 80.0

var vel := Vector2()

onready var headSprite: Sprite = $HeadSprite
onready var headSpriteInitialPos: Vector2 = headSprite.position

func _process(delta):
	headSprite.position = headSpriteInitialPos + _getHeadPosOffset()
	if Input.is_action_pressed("player_move"):
		vel = _calcMoveDirVec() * moveSpeed * delta
	else:
		vel = Vector2.ZERO

func _physics_process(delta):
	move_and_collide(vel)

func _getHeadPosOffset() -> Vector2:
	return _calcMoveDirVec() * Vector2(2, 2)

func _calcMoveDirVec() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
