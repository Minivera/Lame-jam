extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var size
var direction = Vector2(0.0, 1.0)
var scroll_speed


func init(position):
	set_pos(position)

func _ready():

    #size = get_texture().get_size()
    set_process(true)


func _process(delta):
	scroll_speed = get_node("/root/Game").scroll_speed
	var pos = get_pos()
	pos += direction * scroll_speed * delta
	set_pos(pos)