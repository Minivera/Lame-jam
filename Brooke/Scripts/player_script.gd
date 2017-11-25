extends Sprite


# class member variables go here, for example:

var size
var direction = Vector2(0.0, 0.0)
var turnspeed = 0.05
const side_speed = 100
var scroll_speed
var last_trail_segment
var grungyFilthCounter = 0
var mySprite = preload("res://Scenes/trail_segment.tscn").instance() 

func _ready():

    size = get_texture().get_size()
    set_process(true)


func _process(delta):
	var pos = get_pos()
	pos += direction * side_speed  * delta
	set_pos(pos)
	
	#get_node("arrow").set_rot(direction)
	if(Input.is_action_pressed("turn_right") and not direction.x > 1):
		direction.x += turnspeed

	if(Input.is_action_pressed("turn_left") and not direction.x < -1):
		direction.x -= turnspeed

	if(Input.is_action_pressed("correct_vertical") and not Input.is_action_pressed("turn_left") and not Input.is_action_pressed("turn_right")):
		if(direction.x < 0):
			direction.x += turnspeed
		if(direction.x > 0):
			direction.x -= turnspeed
	
	if(grungyFilthCounter >= 10):
		grungyFilthCounter = 0
		get_parent().add_child(mySprite)
		mySprite = preload("res://Scenes/trail_segment.tscn").instance() 
	else:
		grungyFilthCounter += 1
	scroll_speed = sqrt(100.0*100.0 - (direction.x * 100.0) * (direction.x * 100.0))
	get_node("/root/Game").scroll_speed = scroll_speed
	