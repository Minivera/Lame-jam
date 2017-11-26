extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var size
var direction = Vector2(0.0, 1.0)
var scroll_speed




func _ready():
	
	set_process(true)

func _process(delta):
	scroll_speed = get_node("/root/Game").scroll_speed
	var pos = get_pos()
	pos += direction * scroll_speed * delta
	set_pos(pos)