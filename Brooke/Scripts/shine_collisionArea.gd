extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var collision
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	if (self.is_colliding()):
		print(self.get_collider().get_name())