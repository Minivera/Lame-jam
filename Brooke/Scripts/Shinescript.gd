extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = \"textvar\"

var direction = Vector2(0.0, 1.0)
var scroll_speed

var maxleft = -100.0
var maxright = -100.0
var rect
var self_rect
var playerPos
var playerX
var playerY
func init(Left, Right):
	maxleft = Left.x
	maxright = Right.x
	#print("hi")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#size = get_texture().get_size()
	var viewport = get_viewport().get_rect().size
	var viewWidth = viewport[0]
	var viewHeight = viewport[1]
	var position = get_pos()
	position.y = 0
	position.x = round(rand_range(maxleft, maxright))
	set_pos(position)
	#print("hark I am shine i have arrived")
	set_process(true)

func _process(delta):
	scroll_speed = get_node("/root/Game").scroll_speed
	var pos = get_pos()
	pos += direction * scroll_speed * delta
	set_pos(pos)
	playerPos = get_node("/root/Game/CanvasLayer/Player").pos
	#self_rect = get_item_rect()
	#rect = get_node("/root/Game/CanvasLayer/Player").get_item_rect()
	if( pos.x > playerPos.x - 30 and pos.x < playerPos.x + 30 and pos.y > playerPos.y - 30 and pos.y < playerPos.y + 30):
		get_node("/root/Game").shine_meter += 1#
		self.hide()
		self.queue_free()




# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	pass
