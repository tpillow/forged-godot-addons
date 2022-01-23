extends Sprite

func _ready():
	# You could also add this directly in the editor, under the "Node"->"Groups" tab
	# This group should match the group name defined in the FPerspController
	# This is the default group name that is chosen
	add_to_group("forged_persp")

func fpUpdate(fPerspController: FPerspController):
	rotation = fPerspController.rotation
