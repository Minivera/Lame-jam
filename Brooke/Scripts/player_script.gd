extends Sprite


# class member variables go here, for example:

var size
var direction = Vector2(0.0, 0.0)
var turnspeed = 0.05
const side_speed = 100
var scroll_speed
var last_trail_segment
var grungyFilthCounter = 0
var mySprite
var input_timer = null
var segment_timer = null
var speed_adjust_ready = true
var segment_drop_ready = true

func _ready():
	size = get_texture().get_size()
	set_process(true)
	input_timer = Timer.new()
	input_timer.set_wait_time( 0.00001 )
	input_timer.connect("timeout", self, "_on_input_timer_timeout")
	add_child(input_timer)
	segment_timer = Timer.new()
	segment_timer.set_wait_time( 0.1 )
	segment_timer.connect("timeout", self, "_on_segment_timer_timeout")
	add_child(segment_timer)
	
func _on_input_timer_timeout():
	speed_adjust_ready = true

func _on_segment_timer_timeout():
	segment_drop_ready = true

func _process(delta):
	var pos = get_pos()
	pos += direction * side_speed  * delta
	set_pos(pos)
	
	if(Input.is_action_pressed("turn_right") and not direction.x > 1 and speed_adjust_ready):
		direction.x += turnspeed
		speed_adjust_ready = false
		input_timer.start()

	if(Input.is_action_pressed("turn_left") and not direction.x < -1 and speed_adjust_ready):
		direction.x -= turnspeed
		speed_adjust_ready = false
		input_timer.start()

	if(Input.is_action_pressed("correct_vertical") and not Input.is_action_pressed("turn_left") and not Input.is_action_pressed("turn_right") and speed_adjust_ready):
		if(direction.x < 0):
			direction.x += turnspeed
		if(direction.x > 0):
			direction.x -= turnspeed
		speed_adjust_ready = false
		input_timer.start()
	
	if(segment_drop_ready):
		mySprite = preload("res://Scenes/trail_segment.tscn").instance() 
		mySprite.init(pos)
		get_parent().add_child(mySprite)
		segment_drop_ready = false
		segment_timer.start()
	
	
	scroll_speed = sqrt(100.0*100.0 - (abs(direction.x) * 100.0 - 10) * (abs(direction.x) * 100.0 - 10))
	get_node("/root/Game").scroll_speed = scroll_speed
	