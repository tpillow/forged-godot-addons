extends Sprite

export var moveSpeed: float = 50.0

func _process(delta):
	# TODO: should use actions
	if Input.is_key_pressed(KEY_A):
		position.x -= moveSpeed * delta
	elif Input.is_key_pressed(KEY_D):
		position.x += moveSpeed * delta
	if Input.is_key_pressed(KEY_W):
		position.y -= moveSpeed * delta
	elif Input.is_key_pressed(KEY_S):
		position.y += moveSpeed * delta
