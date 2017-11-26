extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = \"textvar\"

var direction = Vector2(0.0, 1.0)
var scroll_speed



func init():
	var viewport = get_viewport().get_rect().size
	var viewWidth = viewport[0]
	var viewHeight = viewport[1]
	var position = get_pos()
	print("hark I am shine i have arrived")
	position.y = 0
	position.x = round(rand_range(0.0, viewWidth))
	set_pos(position)


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#size = get_texture().get_size()
    set_process(true)

func _process(delta):
	scroll_speed = get_node("/root/Game").scroll_speed
	var pos = get_pos()
	pos += direction * scroll_speed * delta
	set_pos(pos)



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	pass
