extends AnimatedSprite


# class member variables go here, for example:

var size
var direction = Vector2(0.0, 0.0)
var turnspeed = 0.15
const side_speed = 100
var scroll_speed
var last_trail_segment
var grungyFilthTimer = null
var mySprite
var input_timer = null
var segment_timer = null
var speed_adjust_ready = true
var segment_drop_ready = true
var decay_ready = true
var sun_frame
var pos = get_pos()
var dead = false
func _ready():
	#size = get_texture().get_size()
	set_process(true)
	input_timer = Timer.new()
	input_timer.set_wait_time( 0.05 )
	input_timer.connect("timeout", self, "_on_input_timer_timeout")
	add_child(input_timer)
	segment_timer = Timer.new()
	segment_timer.set_wait_time( 0.1 )
	segment_timer.connect("timeout", self, "_on_segment_timer_timeout")
	add_child(segment_timer)
	grungyFilthTimer = Timer.new()
	grungyFilthTimer.set_wait_time(1)
	grungyFilthTimer.connect("timeout", self, "_on_grungyFilthTimer_timeout")
	add_child(grungyFilthTimer)
	
func _on_grungyFilthTimer_timeout():
	decay_ready = true
func _on_input_timer_timeout():
	speed_adjust_ready = true

func _on_segment_timer_timeout():
	segment_drop_ready = true

func _process(delta):	
	pos += direction * side_speed  * delta
	set_pos(pos)
	sun_frame = ceil(get_node("/root/Game").shine_meter)
	if(sun_frame > 10):
		sun_frame = 10
	set_frame(sun_frame)
	
	if(Input.is_action_pressed("turn_right") and not direction.x > 0.8 and speed_adjust_ready):
		direction.x += turnspeed
		speed_adjust_ready = false
		input_timer.start()

	if(Input.is_action_pressed("turn_left") and not direction.x < -0.8 and speed_adjust_ready):
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
		mySprite = preload("res://Scenes/trail_segments.tscn").instance() 
		get_parent().add_child(mySprite)
		segment_drop_ready = false
		segment_timer.start()
	if(dead):
		segment_drop_ready = false
		speed_adjust_ready = false
		get_node("/root/Game").scroll_speed = 0
		if(sun_frame >0 and decay_ready):
			sun_frame -= 1
			grungyFilthTimer.start
			decay_ready = false
		else:
			self.hide()
			self.queue_free()
			#delete player sprite 
	else:
		scroll_speed = sqrt(abs(100.0*100.0 - (abs(direction.x) * 100.0 - 10) * (abs(direction.x) * 100.0 - 10)))
		get_node("/root/Game").scroll_speed = scroll_speed
	

	