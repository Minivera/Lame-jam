extends Node

var scroll_speed = 100
var timer = null
var ready = true
var shine_meter = 0
var mySprite
var total_scroll = 0
var LeftPath = Vector2(-100.0, 0)
var RightPath = Vector2(-100.0, 0)
var smacked = false
var playShineSound = false



func _ready():
	set_process(true)
	timer = Timer.new()
	timer.set_wait_time(10)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

func _on_timer_timeout():
	ready = true

func _process(delta):
	if (get_node("CanvasLayer/Player").dead && !smacked):
		get_node("SamplePlayer").play("smack")
	if (ready): # If it's time to spawn another Shine
		mySprite = preload("res://Scenes/Shine2.tscn").instance() 
		LeftPath = get_node("Sides").LeftPath[0]
		RightPath = get_node("Sides").RightPath[0]
		mySprite.init(LeftPath, RightPath)
		add_child(mySprite)
		ready = false
		timer.start()
	if (playShineSound):
		get_node("SamplePlayer").play("ding")