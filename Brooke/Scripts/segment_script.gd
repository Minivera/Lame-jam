extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var size
var direction = Vector2(0.0, 1.0)
var scroll_speed
var random_int



func _ready():
	random_int = round(rand_range(0.0,6.4))
	set_frame(random_int)
    #size = get_texture().get_size()
	set_process(true)
	set_pos(get_node("/root/Game/CanvasLayer/Player").pos)

func _process(delta):
	scroll_speed = get_node("/root/Game").scroll_speed
	var pos = get_pos()
	pos += direction * scroll_speed * delta
	set_pos(pos)